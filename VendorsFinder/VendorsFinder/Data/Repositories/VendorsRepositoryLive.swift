//
//  VendorsRepositoryLive.swift
//  VendorsFinder
//
//  Created by Ivan Petrov on 17.09.2025.
//


/// __
/// for the future (real API)
/// Use it when the backend appears
/// One-line switch in the VendorsViewModel's init


import Foundation

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
