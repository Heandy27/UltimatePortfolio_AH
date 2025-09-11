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
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            NavigationSplitView {
                SidebarView(dataController: dataController)
            } content: {
                ContentView()
            } detail: {
                DetailView()
            }
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
                .onChange(of: scenePhase) { oldValue, newValue in
                    if newValue != .active {
                        dataController.save()
                    }
                }
        }
    }
}

