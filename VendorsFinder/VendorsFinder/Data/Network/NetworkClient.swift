//
//  NetworkClient.swift
//  VendorsFinder
//
//  Created by Ivan Petrov on 17.09.2025.
//


/// __
/// for the future (real API)
/// Use it when the backend appears

/// __
/// do nothing

//import Foundation
//
//enum NetworkError: Error { case badResponse, decoding }
//
//protocol NetworkClient {
//    func request<T: Decodable>(_ endpoint: APIEndpoint, as type: T.Type) async throws -> T
//}
//
//final class URLSessionNetworkClient: NetworkClient {
//    func request<T: Decodable>(_ endpoint: APIEndpoint, as type: T.Type) async throws -> T {
//        let (data, resp) = try await URLSession.shared.data(for: endpoint.request)
//        
//        guard let http = resp as? HTTPURLResponse,
//              200..<300 ~= http.statusCode
//        else {
//            throw NetworkError.badResponse
//        }
//        
//        do {
//            return try JSONDecoder().decode(T.self, from: data)
//        } catch {
//            throw NetworkError.decoding
//        }
//    }
//}
