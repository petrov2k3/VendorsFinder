//
//  Media.swift
//  VendorsFinder
//
//  Created by Ivan Petrov on 16.09.2025.
//

import Foundation

struct Media: Decodable, Equatable {
    let id: Int
    let media_url: String
    let media_type: String
}
