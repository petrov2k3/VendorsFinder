//
//  VendorCard.swift
//  VendorsFinder
//
//  Created by Ivan Petrov on 16.09.2025.
//

import SwiftUI
import Kingfisher
import SDWebImageSwiftUI

struct VendorCard: View {
    let vendor: Vendor
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
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
                        DownsamplingImageProcessor(size: CGSize(width: UIScreen.main.bounds.width, height: 170))
                    )
                    .resizable()
                    .scaledToFill()
                    .frame(height: 170)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button {
                    // TODO: add action on favorited button tap
                } label: {
                    (vendor.favorited == true
                        ? Theme.Icons.favoritedActive
                        : Theme.Icons.favoritedInactive
                    )
                }
                .padding(.top, 5)
                .padding(.trailing, -5)
            }
            .overlay(alignment: .bottomLeading) {
                if let area = vendor.areaServed, !area.isEmpty {
                    Text(area)
                        .font(Theme.Fonts.body())
                        .padding(.horizontal, 10).padding(.vertical, 6)
                        .background(.white)
                        .opacity(0.9)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(8)
                }
            }
            
            Text(vendor.companyName)
                .font(Theme.Fonts.headline())
            
            if let categories = vendor.categories {
                HStack(spacing: 12) {
                    ForEach(categories.prefix(2)) { category in
                        HStack(spacing: 4) {
                            WebImage(url: URL(string: category.image?.mediaURL ?? ""))
                                .resizable()
                                .indicator(.activity)
                                .scaledToFit()
                                .frame(width: 22, height: 22)
                            
                            Text(category.name)
                                .font(Theme.Fonts.body())
                        }
                    }
                }
                .foregroundStyle(Theme.Colors.greyPrimary)
            }
            
            if let tags = vendor.tags, !tags.isEmpty {
                Text(tags.map { "\u{2022} \($0.name)" }.joined(separator: " "))
                    .font(Theme.Fonts.body())
                    .foregroundStyle(Theme.Colors.greySecondary)
            }
        }
    }
}

//#Preview {
//    VendorCard()
//}
