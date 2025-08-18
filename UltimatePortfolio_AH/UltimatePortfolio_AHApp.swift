//
//  UltimatePortfolio_AHApp.swift
//  UltimatePortfolio_AH
//
//  Created by Andy Heredia on 18/8/25.
//

import SwiftUI

@main
struct UltimatePortfolio_AHApp: App {
    
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
        }
    }
}
