//
//  NoResultsView.swift
//  VendorsFinder
//
//  Created by Ivan Petrov on 16.09.2025.
//

import SwiftUI

struct NoResultsView: View {
    let searchText: String

    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            
            Text("Sorry! No results found...")
                .font(Theme.Fonts.title())
                .foregroundStyle(Theme.Colors.darkGreen)
            
            Text("Please try a different search request\nor browse businesses from the list")
                .multilineTextAlignment(.center)
                .font(Theme.Fonts.subhead())
                .foregroundStyle(Theme.Colors.greyPrimary)
                .padding(.horizontal, 24)
            
            Spacer()
        }
    }
}

//#Preview {
//    NoResultsView()
//}
