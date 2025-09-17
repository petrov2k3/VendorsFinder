//
//  VendorsViewModel.swift
//  VendorsFinder
//
//  Created by Ivan Petrov on 16.09.2025.
//

import Foundation
import Observation

@MainActor
@Observable
final class VendorsViewModel {
    
    // MARK: - Properties
    
    // input
    var searchText: String = "" {
        didSet { scheduleDebouncedReload() }
    }

    // state
    private(set) var items: [Vendor] = []
    private(set) var isLoading: Bool = false        // common loader (+ search)
    private(set) var isLoadingMore: Bool = false    // pagination loader
    private(set) var canLoadMore: Bool = true

    // deps
    private let repo: VendorsRepository

    // paging
    private var currentPage: Int = 0
    private let pageSize: Int = 12

    // debounce / cancellation
    private var searchTask: Task<Void, Never>?
    private var loadTask: Task<Void, Never>?
    private var searchToken = UUID() // current search marker

    private var effectiveQuery: String? {
        searchText.count >= 3 ? searchText : nil
    }
    
    var isShowEmptyStateNeeded: Bool {
        /// show empty state when there is no loading and there is an active search query
        
        !isLoading && items.isEmpty && (effectiveQuery != nil)
    }
    
    // MARK: - Inits
    
    /// change VendorsRepositoryMock() to VendorsRepositoryLive() when it's real API integration
    
    init(repo: VendorsRepository = VendorsRepositoryMock()) {
        self.repo = repo
        Task { await reload() }
    }

    // MARK: - Private methods
    
    private func scheduleDebouncedReload() {
        searchTask?.cancel()
        
        searchTask = Task { [weak self] in
            try? await Task.sleep(nanoseconds: 500_000_000)
            await self?.reload()
        }
    }
    
    // MARK: - Public methods
    
    func reload() async {
        isLoading = true
        isLoadingMore = false
        canLoadMore = true
        currentPage = 0
        
        let token = UUID()
        searchToken = token
        
        loadTask?.cancel()
        loadTask = Task { [weak self] in
            guard let self else { return }
            
            do {
                let first = try await repo.fetchVendors(
                    page: 0,
                    pageSize: pageSize,
                    query: effectiveQuery
                )
                
                // ignore the outdated response
                guard token == self.searchToken else { return }
                
                self.items = first
                self.canLoadMore = !first.isEmpty
                self.currentPage = first.isEmpty ? 0 : 1
                
            } catch {
                // in the mock mode, errors are unlikely, but:
                // TODO: add error state
                
                self.canLoadMore = false
            }
            
            self.isLoading = false
        }
    }
    
    func loadMoreIfNeeded(currentItem: Vendor?) {
        guard let item = currentItem, items.last?.id == item.id else { return }
        guard canLoadMore, !isLoadingMore else { return }
        
        isLoadingMore = true
        
        let page = currentPage
        let token = searchToken
        
        Task { [weak self] in
            guard let self else { return }
            
            do {
                let next = try await repo.fetchVendors(page: page, pageSize: pageSize, query: effectiveQuery)
                
                // ignoring if a new search has started during this time
                guard token == self.searchToken else { return }
                
                if next.isEmpty {
                    self.canLoadMore = false
                } else {
                    self.items += next
                    self.currentPage += 1
                }
            } catch {
                self.canLoadMore = false
            }
            
            self.isLoadingMore = false
        }
    }
}
