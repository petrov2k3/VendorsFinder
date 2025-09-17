//
//  APIEndpoint.swift
//  VendorsFinder
//
//  Created by Ivan Petrov on 17.09.2025.
//

/// __
/// do nothing

import Foundation

enum APIEndpoint {
    case vendors(page: Int, pageSize: Int, query: String?)

    var request: URLRequest {
        var components = URLComponents(string: "https://api.example.com/vendors")!
        
        switch self {
        case let .vendors(page, pageSize, query):
            var items = [
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "pageSize", value: String(pageSize))
            ]
            
            if let q = query, !q.isEmpty {
                items.append(URLQueryItem(name: "q", value: q))
            }
            
            components.queryItems = items
        }
        
        let url = components.url!
        var req = URLRequest(url: url)
        
        req.httpMethod = "GET"
        
        return req
    }
}
