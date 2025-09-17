//
//  String+Normalize.swift
//  VendorsFinder
//
//  Created by Ivan Petrov on 17.09.2025.
//

import Foundation

extension String {
    var normalizedSearchKey: String {
        folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
    }
}
