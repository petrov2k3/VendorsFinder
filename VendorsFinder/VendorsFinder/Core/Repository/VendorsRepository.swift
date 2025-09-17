//
//  VendorsRepository.swift
//  VendorsFinder
//
//  Created by Ivan Petrov on 16.09.2025.
//

import Foundation

protocol VendorsRepository {
    func loadAllVendors() throws -> [Vendor]
}
