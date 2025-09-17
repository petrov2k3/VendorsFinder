//
//  VendorCard.swift
//  VendorsFinder
//
//  Created by Ivan Petrov on 16.09.2025.
//

import SwiftUI

struct VendorCard: View {
    let vendor: Vendor

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .bottomLeading) {
                AsyncImage(url: URL(string: vendor.cover_photo?.media_url ?? "")) { img in
                    img.resizable().scaledToFill()
                } placeholder: {
                    Rectangle().opacity(0.1)
                }
                .frame(height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 10))

                HStack {
                    if let city = vendor.area_served, !city.isEmpty {
                        Text(city)
                            .font(.caption)
                            .padding(.horizontal, 10).padding(.vertical, 6)
                            .background(.ultraThinMaterial)
                            .clipShape(Capsule())
                            .padding(8)
                    }
                    Spacer()
                }
            }

            Text(vendor.company_name)
                .font(.headline)

            HStack(spacing: 12) {
                if let shop = vendor.shop_type, !shop.isEmpty {
                    Label(shop, systemImage: "bag.fill")
                        .font(.caption)
                }
                // maybe display the first category as the second tag
            }
            .foregroundStyle(.secondary)

            // description (placeholder)
            Text("• Best in town • Discounts for customers")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 8)
    }
}

//#Preview {
//    VendorCard()
//}
