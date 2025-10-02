//
//  NumberBadge.swift
//  UltimatePortfolio_AH
//
//  Created by Andy Heredia on 2/10/25.
//

import SwiftUI

extension View {
    func numberBadge(_ number: Int) -> some View {
        #if os(watchOS)
        self
        #else
        self.badge(number)
        #endif
    }
}
