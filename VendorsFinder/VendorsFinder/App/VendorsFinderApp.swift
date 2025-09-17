//
//  VendorsFinderApp.swift
//  VendorsFinder
//
//  Created by Ivan Petrov on 16.09.2025.
//

import SwiftUI
import Kingfisher

@main
struct VendorsFinderApp: App {
    init() {
        let cache = KingfisherManager.shared.cache
        
        cache.memoryStorage.config.totalCostLimit = 100 * 1024 * 1024
        cache.diskStorage.config.sizeLimit = 300 * 1024 * 1024
    }
    
    var body: some Scene {
        WindowGroup {
            VendorsView()
        }
    }
}
