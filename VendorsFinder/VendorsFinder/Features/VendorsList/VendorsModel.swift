//
//  VendorsModel.swift
//  VendorsFinder
//
//  Created by Ivan Petrov on 16.09.2025.
//

import Foundation
import Observation

@MainActor
@Observable
final class VendorsModel {
    // input
    var searchText: String = "" {
        didSet { scheduleDebouncedSearch() }
    }

    // state
    private(set) var items: [Vendor] = []
    private(set) var isLoading: Bool = false
    private(set) var canLoadMore: Bool = true
    private(set) var isEmpty: Bool = false

    // deps
    private let repo: VendorsRepository
    private var dataSource: PagedVendorsDataSource!

    // paging
    private var currentPage: Int = 0

    // debounce
    private var searchTask: Task<Void, Never>?

    init(repo: VendorsRepository = JSONVendorsRepository()) {
        self.repo = repo
        setup()
    }

    private func setup() {
        let all = (try? repo.loadAllVendors()) ?? []
        dataSource = PagedVendorsDataSource(all: all, pageSize: 12)
        reload()
    }

    private func scheduleDebouncedSearch() {
        searchTask?.cancel()
        searchTask = Task { [weak self] in
            try? await Task.sleep(nanoseconds: 500_000_000) // 0.5s
            await self?.applySearch()
        }
    }

    private func effectiveQuery() -> String? {
        searchText.count >= 3 ? searchText : nil
    }

    func reload() {
        isLoading = true
        currentPage = 0
        let first = dataSource.page(index: currentPage, query: effectiveQuery())
        items = first
        canLoadMore = !first.isEmpty
        isEmpty = first.isEmpty
        isLoading = false
    }

    func applySearch() {
        reload()
    }

    func loadMoreIfNeeded(currentItem: Vendor?) {
        guard let item = currentItem else { return }
        guard canLoadMore, !isLoading, items.last?.id == item.id else { return }

        isLoading = true
        currentPage += 1
        let next = dataSource.page(index: currentPage, query: effectiveQuery())
        items.append(contentsOf: next)
        canLoadMore = !next.isEmpty
        isLoading = false
    }
}
