//
//  VendorsRepositoryMock.swift
//  VendorsFinder
//
//  Created by Ivan Petrov on 17.09.2025.
//


/// __
/// json + server emulation (pagination + search)


import Foundation

final class VendorsRepositoryMock: VendorsRepository {
    private let allVendors: [Vendor]

    init() {
        let vendors: [Vendor] = {
            
            /// __
            /// Choose a needed url guard below
            /// vendors.json                    -       original file from the Technical Specifications
            /// vendorsExtended.json     -      extended file with 36 vendors to emulate the real response from the API
            
            //guard let url = Bundle.main.url(forResource: "vendorsExtended", withExtension: "json"),
            guard let url = Bundle.main.url(forResource: "vendors", withExtension: "json"),
                  let data = try? Data(contentsOf: url),
                  let decoded = try? JSONDecoder().decode(Vendors.self, from: data)
            else { return [] }
            
            return decoded.vendors
        }()
        
        /// _
        /// guaranteed 3 pages in the if block below (if there is little data when using original vendors.json file)
        /// just making copies with different identifiers and company names
        if vendors.count < 36 { // with pageSize=12 it will give 3 pages
            var expanded: [Vendor] = []
            let copies = max(3, Int(ceil(Double(36) / Double(max(1, vendors.count)))))
            
            for copy in 0..<copies {
                expanded += vendors.map { vendor in
                    Vendor(
                        id: vendor.id * 1000 + copy,
                        companyName: "\(vendor.companyName) #\(copy + 1)",
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
            self.allVendors = expanded
        } else {
            self.allVendors = vendors
        }
    }

    func fetchVendors(page: Int, pageSize: Int, query: String?) async throws -> [Vendor] {
        // simulate network latency
        try? await Task.sleep(nanoseconds: 250_000_000) // 0.25s

        // filter (from search) only by companyName (>= 3 characters)
        let filtered: [Vendor]
        
        if let query = query, query.count >= 3 {
            let key = query.normalizedSearchKey
            
            filtered = allVendors.filter {
                $0.companyName.normalizedSearchKey
                    .contains(key)
            }
        } else {
            filtered = allVendors
        }

        // server-side-like pagination
        let start = page * pageSize
        
        guard start < filtered.count else { return [] }
        
        let end = min(start + pageSize, filtered.count)
        
        return Array(filtered[start..<end])
    }
}
