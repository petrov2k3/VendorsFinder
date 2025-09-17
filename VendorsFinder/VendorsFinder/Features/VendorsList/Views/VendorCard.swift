//
//  VendorCard.swift
//  VendorsFinder
//
//  Created by Ivan Petrov on 16.09.2025.
//

import SwiftUI
import Kingfisher

struct VendorCard: View {
    let vendor: Vendor

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .bottomLeading) {
                KFImage(URL(string: vendor.coverPhoto?.mediaURL ?? ""))
                    .placeholder {
                        ZStack {
                            Rectangle()
                                .opacity(0.1)
                            ProgressView()
                        }
                    }
                    .cancelOnDisappear(true)
                    .loadDiskFileSynchronously()
                    .cacheOriginalImage()
                    .fade(duration: 0.2)
                    .setProcessor(
                        DownsamplingImageProcessor(size: CGSize(width: UIScreen.main.bounds.width, height: 160))
                    )
                    .resizable()
                    .scaledToFill()
                    .frame(height: 160)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                HStack {
                    if let areaServed = vendor.areaServed, !areaServed.isEmpty {
                        Text(areaServed)
                            .font(.caption)
                            .padding(.horizontal, 10).padding(.vertical, 6)
                            .background(.ultraThinMaterial)
                            .clipShape(Capsule())
                            .padding(8)
                    }
                    Spacer()
                }
            }

            Text(vendor.companyName)
                .font(.headline)

            HStack(spacing: 12) {
                if let shop = vendor.shopType, !shop.isEmpty {
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
