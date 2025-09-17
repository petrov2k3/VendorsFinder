//
//  VendorsView.swift
//  VendorsFinder
//
//  Created by Ivan Petrov on 16.09.2025.
//

import SwiftUI

struct VendorsView: View {
    @State private var vm = VendorsViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                SearchBar(text: $vm.searchText)

                ZStack {
                    List {
                        ForEach(vm.items) { vendor in
                            VendorCard(vendor: vendor)
                                .listRowSeparator(.hidden)
                                .onAppear { vm.loadMoreIfNeeded(currentItem: vendor) }
                        }

                        if vm.isLoadingMore {
                            HStack { Spacer(); ProgressView(); Spacer() }
                                .listRowSeparator(.hidden)
                        }
                    }
                    .listStyle(.plain)
                    .animation(nil, value: vm.items)

                    // loader overlay on first request/search
                    if vm.isLoading && vm.items.isEmpty {
                        ProgressView().scaleEffect(1.2)
                    }
                    
                    if vm.isShowEmptyStateNeeded {
                        NoResultsView(searchText: vm.searchText)
                            .padding(.horizontal, 24)
                    }
                }
            }
//            .navigationTitle("Vendors")
//            .navigationBarTitleDisplayMode(.inline)
//            .searchable(text: $vm.searchText, prompt: "Search...") // native search
        }
    }
}

//#Preview {
//    VendorsView()
//}
