//
//  Theme.swift
//  VendorsFinder
//
//  Created by Ivan Petrov on 18.09.2025.
//

import SwiftUI

enum Theme {
    enum Colors {
        static let greyPrimary   = Color("grey_primary")
        static let greySecondary = Color("grey_secondary")
        static let green         = Color("green")
        static let darkGreen     = Color("dark_green")
        static let white         = Color("white")
    }

    enum Icons {
        static let search = Image("ic_search")
    }

    enum Fonts {
        static func title(_ size: CGFloat = 24) -> Font {
            .custom("OpenSans-Bold", size: size)
        }
        
        static func headline(_ size: CGFloat = 16) -> Font {
            .custom("OpenSans-Bold", size: size)
        }
        
        static func subhead(_ size: CGFloat = 16) -> Font {
            .custom("OpenSans-Regular", size: size)
        }
        
        static func body(_ size: CGFloat = 14) -> Font {
            .custom("OpenSans-Regular", size: size)
        }
    }
}
