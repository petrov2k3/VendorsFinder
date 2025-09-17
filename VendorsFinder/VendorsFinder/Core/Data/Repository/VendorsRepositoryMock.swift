//
//  VendorsRepositoryMock.swift
//  VendorsFinder
//
//  Created by Ivan Petrov on 17.09.2025.
//

import Foundation

final class VendorsRepositoryMock: VendorsRepository {
    private let all: [Vendor]

    init() {
        // read vendors.json once
        let vendors: [Vendor] = {
            guard let url = Bundle.main.url(forResource: "vendors", withExtension: "json"),
                  let data = try? Data(contentsOf: url),
                  let decoded = try? JSONDecoder().decode(Vendors.self, from: data)
            else { return [] }
            
            return decoded.vendors
        }()

        // guaranteed ≥3 pages (if there is little data)
        if vendors.count < 36 { // with pageSize=12 it will give 3 pages
            var expanded: [Vendor] = []
            let copies = max(3, Int(ceil(Double(36) / Double(max(1, vendors.count)))))
            for c in 0..<copies {
                expanded += vendors.map { vendor in
                    Vendor(
                        id: vendor.id * 1000 + c,
                        companyName: "\(vendor.companyName) #\(c+1)",
                        areaServed: vendor.areaServed,
                        shopType: vendor.shopType,
                        favorited: vendor.favorited,
                        follow: vendor.follow,
                        businessType: vendor.businessType,
                        coverPhoto: vendor.coverPhoto,
                        categories: vendor.categories,
                        tags: vendor.tags
                    )
                }
            }
            self.all = expanded
        } else {
            self.all = vendors
        }
    }

    func fetchVendors(page: Int, pageSize: Int, query: String?) async throws -> [Vendor] {
        // simulate network latency to show loader
        try? await Task.sleep(nanoseconds: 250_000_000) // 0.25s

        // filter only by companyName (>= 3 characters)
        let filtered: [Vendor]
        
        if let query = query, query.count >= 3 {
            let key = query.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
            
            filtered = all.filter {
                $0.companyName.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
                    .contains(key)
            }
        } else {
            filtered = all
        }

        // server-side pagination
        let start = page * pageSize
        
        guard start < filtered.count else { return [] }
        
        let end = min(start + pageSize, filtered.count)
        
        return Array(filtered[start..<end])
    }
}
