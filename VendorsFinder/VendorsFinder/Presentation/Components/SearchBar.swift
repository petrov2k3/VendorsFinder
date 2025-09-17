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
    var bottomSpacing: CGFloat = 12

    var body: some View {
        HStack(spacing: 8) {
            TextField(placeholder, text: $text)
                .focused($isFocused)
                .textInputAutocapitalization(.words)
                .keyboardType(.default)
                .autocorrectionDisabled(true)
                .submitLabel(.search)
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .frame(height: 40)

            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 16))
                        .foregroundStyle(.green)
                }
                .padding(.trailing, 4)
                .transition(.scale.combined(with: .opacity))
            }

            Image(systemName: "magnifyingglass")
                .font(.system(size: 18))
                .foregroundStyle(.secondary)
                .padding(.trailing, 12)
        }
        .animation(.easeInOut(duration: 0.2), value: text.isEmpty)
        .background(
            Color.white,
            in: RoundedRectangle(cornerRadius: 12, style: .continuous)
        )
        .shadow(color: .black.opacity(0.08), radius: 8, y: 2)
        .padding(.horizontal, 16)
        .padding(.top, 24)
        .padding(.bottom, bottomSpacing)
        .contentShape(Rectangle())
        .onTapGesture { isFocused = true }
    }
}

//#Preview {
//    SearchBar()
//}
