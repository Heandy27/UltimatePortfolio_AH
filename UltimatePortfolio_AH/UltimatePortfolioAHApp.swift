//
//  UltimatePortfolio_AHApp.swift
//  UltimatePortfolio_AH
//
//  Created by Andy Heredia on 18/8/25.
//
#if canImport(CoreSpotlight)
import CoreSpotlight
#endif
import SwiftUI
import CoreData

@main
struct UltimatePortfolio_AHApp: App {
    
    @StateObject var dataController = DataController()
    @Environment(\.scenePhase) var scenePhase
    
    #if os(iOS)
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #endif
    var body: some Scene {
        WindowGroup {
            NavigationSplitView {
                SidebarView(dataController: dataController)
            } content: {
                ContentView(dataController: dataController)
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
            #if canImport(CoreSpotlight)
                .onContinueUserActivity(CSSearchableItemActionType, perform: loadSpotlightItem)
            #endif
        }
    }
    #if canImport(CoreSpotlight)
    func loadSpotlightItem(_ userActivity: NSUserActivity) {
        if let uniqueIdentifier = userActivity.userInfo?[CSSearchableItemActivityIdentifier] as? String {
            dataController.selectedIssue = dataController.issue(with: uniqueIdentifier)
            dataController.selectedFilter = .all
        }
    }
    #endif
}

