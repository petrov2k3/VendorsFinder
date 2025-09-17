//
//  PagedVendorsDataSource.swift
//  VendorsFinder
//
//  Created by Ivan Petrov on 17.09.2025.
//

import Foundation

final class PagedVendorsDataSource {
    private let all: [Vendor]
    private let pageSize: Int

    init(all: [Vendor], pageSize: Int = 12) {
        if all.count < pageSize * 3 {
            var expanded: [Vendor] = []
            
            let copies = max(3, (pageSize * 3 + all.count - 1) / max(all.count, 1))
            
            for c in 0..<copies {
                expanded += all.map { v in
                    Vendor(
                        id: v.id * 1000 + c,
                        company_name: "\(v.company_name) #\(c+1)",
                        area_served: v.area_served,
                        shop_type: v.shop_type,
                        favorited: v.favorited,
                        follow: v.follow,
                        business_type: v.business_type,
                        cover_photo: v.cover_photo
                    )
                }
            }
            self.all = expanded
        } else {
            self.all = all
        }
        
        self.pageSize = pageSize
    }

    func page(index: Int, query: String?) -> [Vendor] {
        let filtered = Self.filter(all: all, by: query)
        let start = index * pageSize
        
        guard start < filtered.count else { return [] }
        
        let end = min(start + pageSize, filtered.count)
        
        return Array(filtered[start..<end])
    }

    private static func filter(all: [Vendor], by query: String?) -> [Vendor] {
        guard let q = query, q.count >= 3 else { return all }
        let key = q.normalizedSearchKey
        
        return all.filter { $0.company_name.normalizedSearchKey.contains(key) }
    }
}
