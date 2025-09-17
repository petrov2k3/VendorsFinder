//
//  VendorsRepository.swift
//  VendorsFinder
//
//  Created by Ivan Petrov on 16.09.2025.
//

import Foundation

protocol VendorsRepository {
    
    /// emulating a real server: pagination + search
    
    func fetchVendors(page: Int, pageSize: Int, query: String?) async throws -> [Vendor]
}
