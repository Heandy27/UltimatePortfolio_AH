//
//  PortfolioWidgetBundle.swift
//  PortfolioWidget
//
//  Created by Andy Heredia on 29/9/25.
//

import WidgetKit
import SwiftUI

@main
struct PortfolioWidgetBundle: WidgetBundle {
    var body: some Widget {
        SimplePortfolioWidget()
        ComplexPortfolioWidget()
    }
}
