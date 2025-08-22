//
//  ContentView.swift
//  UltimatePortfolio_AH
//
//  Created by Andy Heredia on 18/8/25.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var dataController: DataController
    
    var body: some View {
        List(selection: $dataController.selectedIssue) {
            ForEach(dataController.issuesForSelectedFilter()) { issue in
                IssueRowView(issue: issue)
            }
            .onDelete(perform: delete)
        }
        .navigationTitle("Issues")
        .searchable(text: $dataController.filterText, tokens: $dataController.filterTokens, suggestedTokens: .constant(dataController.suggestedFilterTokens), prompt: "Filter issues, or type # to add tags") { tag in
            Text(tag.tagName)
        }
    }
    func delete(_ offsets: IndexSet) {
        
        let issues = dataController.issuesForSelectedFilter()
        
        for offset in offsets { // índices a borrar (de onDelete)
            let item = issues[offset] // obtiene el Tag en ese índice
            dataController.delete(item) // elimina en Core Data y guarda
        }
    }
}

#Preview {
    ContentView()
}
