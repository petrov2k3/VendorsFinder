//
//  Vendor.swift
//  VendorsFinder
//
//  Created by Ivan Petrov on 16.09.2025.
//

import Foundation

// MARK: - Vendors

struct Vendors: Codable {
    let vendors: [Vendor]
}

// MARK: - Vendor

struct Vendor: Identifiable, Codable, Equatable {
    let id: Int
    let companyName: String
    let areaServed, shopType: String?
    let favorited, follow: Bool?
    let businessType: String?
    let coverPhoto: CoverPhoto?
    let categories: [Category]?
    let tags: [Tag]?

    enum CodingKeys: String, CodingKey {
        case id
        case companyName = "company_name"
        case areaServed = "area_served"
        case shopType = "shop_type"
        case favorited, follow
        case businessType = "business_type"
        case coverPhoto = "cover_photo"
        case categories, tags
    }
}

// MARK: - Category

struct Category: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let image: CoverPhoto?
}

// MARK: - CoverPhoto

struct CoverPhoto: Codable, Equatable {
    let id: Int
    let mediaURL: String
    let mediaType: MediaType

    enum CodingKeys: String, CodingKey {
        case id
        case mediaURL = "media_url"
        case mediaType = "media_type"
    }
}

enum MediaType: String, Codable {
    case image
}

// MARK: - Tag

struct Tag: Identifiable, Codable, Equatable {
    let id: Int
    let name, purpose: String
}
