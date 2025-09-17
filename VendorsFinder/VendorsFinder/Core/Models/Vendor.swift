//
//  Vendor.swift
//  VendorsFinder
//
//  Created by Ivan Petrov on 16.09.2025.
//

import Foundation

struct Vendor: Identifiable, Decodable, Equatable {
    let id: Int
    let company_name: String
    let area_served: String?
    let shop_type: String?
    let favorited: Bool?
    let follow: Bool?
    let business_type: String?
    let cover_photo: Media?
    
    // TODO: add categories/tags
}
