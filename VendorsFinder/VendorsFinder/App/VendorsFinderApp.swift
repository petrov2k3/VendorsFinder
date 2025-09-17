//
//  VendorsFinderApp.swift
//  VendorsFinder
//
//  Created by Ivan Petrov on 16.09.2025.
//

import SwiftUI
import Kingfisher
import SDWebImageSVGCoder

@main
struct VendorsFinderApp: App {
    init() {
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
        
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
