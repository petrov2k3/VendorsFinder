//
//  JSONVendorsRepository.swift
//  VendorsFinder
//
//  Created by Ivan Petrov on 16.09.2025.
//

import Foundation

final class JSONVendorsRepository: VendorsRepository {
    func loadAllVendors() throws -> [Vendor] {
        guard let url = Bundle.main.url(forResource: "vendors", withExtension: "json") else {
            throw NSError(domain: "VendorFinder", code: 1, userInfo: [NSLocalizedDescriptionKey: "vendors.json not found"])
        }
        
        let data = try Data(contentsOf: url)
        
        return try JSONDecoder().decode(VendorsResponse.self, from: data).vendors
    }
}
