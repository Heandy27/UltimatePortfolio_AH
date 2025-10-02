//
//  ToolbarItemPlacement.swift
//  UltimatePortfolio_AH
//
//  Created by Andy Heredia on 2/10/25.
//

import SwiftUI

extension ToolbarItemPlacement {
#if os(watchOS)
    static let automaticOrLeading = ToolbarItemPlacement.topBarLeading
    static let automaticOrTrailing = ToolbarItemPlacement.topBarTrailing
#else
    static let automaticOrLeading = ToolbarItemPlacement.automatic
    static let automaticOrTrailing = ToolbarItemPlacement.automatic
#endif
}
