//
//  InlineNavigationBar.swift
//  UltimatePortfolio_AH
//
//  Created by Andy Heredia on 1/10/25.
//

import SwiftUI

extension View {
    func inlineNavigationBar() -> some View {
        #if os(macOS)
        self
        #else
        self.navigationBarTitleDisplayMode(.inline)
        #endif
    }
}
