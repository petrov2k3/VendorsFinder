//
//  VendorsRepositoryLive.swift
//  VendorsFinder
//
//  Created by Ivan Petrov on 17.09.2025.
//

import Foundation

/// Use it when the backend appears
/// One-line switch in VendorsViewModel's init

//final class VendorsRepositoryLive: VendorsRepository {
//    private let client: NetworkClient
//    init(client: NetworkClient = URLSessionNetworkClient()) { self.client = client }
//
//    func fetchVendors(page: Int, pageSize: Int, query: String?) async throws -> [Vendor] {
//        let response: VendorsResponse = try await client.request(.vendors(page: page, pageSize: pageSize, query: query), as: VendorsResponse.self)
//        
//        return response.vendors
//    }
//}
