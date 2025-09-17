//
//  VendorsScreen.swift
//  VendorsFinder
//
//  Created by Ivan Petrov on 16.09.2025.
//

import SwiftUI

//struct VendorsScreen: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}

struct VendorsScreen: View {
    @State private var vm = VendorsModel()

    var body: some View {
        NavigationStack {
            Group {
                if vm.isEmpty {
                    NoResultsView(searchText: vm.searchText)
                } else {
                    List {
                        ForEach(vm.items) { vendor in
                            VendorCard(vendor: vendor)
                                .listRowSeparator(.hidden)
                                .onAppear { vm.loadMoreIfNeeded(currentItem: vendor) }
                        }

                        if vm.isLoading {
                            HStack { Spacer(); ProgressView(); Spacer() }
                                .listRowSeparator(.hidden)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Vendors")
            .searchable(text: $vm.searchText, prompt: "Search by company name")
        }
    }
}

//#Preview {
//    VendorsScreen()
//}
