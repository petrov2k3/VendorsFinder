//
//  SearchBar.swift
//  VendorsFinder
//
//  Created by Ivan Petrov on 17.09.2025.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    var placeholder: String = "Search..."
    var bottomSpacing: CGFloat = 24

    var body: some View {
        HStack(spacing: 8) {
            TextField(
                "",
                text: $text,
                prompt: Text(placeholder)
                    .foregroundStyle(Theme.Colors.greySecondary)
                    .font(Theme.Fonts.subhead())
            )
            .focused($isFocused)
            .textInputAutocapitalization(.words)
            .keyboardType(.default)
            .autocorrectionDisabled(true)
            .submitLabel(.search)
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .padding(.leading, 4)
            .frame(height: 40)
            .foregroundStyle(Theme.Colors.greyPrimary)
            .font(Theme.Fonts.subhead())
            
            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 16))
                        .foregroundStyle(Theme.Colors.green)
                }
                .padding(.trailing, 4)
                .transition(.scale.combined(with: .opacity))
            }

            Theme.Icons.search
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .padding(.trailing, 12)
        }
        .animation(.easeInOut(duration: 0.2), value: text.isEmpty)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Theme.Colors.white)
                .shadow(color: .black.opacity(0.08), radius: 8, y: 2)
        )
        .shadow(color: .black.opacity(0.08), radius: 8, y: 2)
        .padding(.horizontal, 16)
        .padding(.top, 24)
        .padding(.bottom, bottomSpacing)
        .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .onTapGesture { isFocused = true }
    }
}

//#Preview {
//    SearchBar()
//}
