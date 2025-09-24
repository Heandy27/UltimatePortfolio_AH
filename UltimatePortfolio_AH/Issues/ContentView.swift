//
//  ContentView.swift
//  UltimatePortfolio_AH
//
//  Created by Andy Heredia on 18/8/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.requestReview) var requestReview
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        List(selection: $viewModel.selectedIssue) {
            ForEach(viewModel.dataController.issuesForSelectedFilter()) { issue in
                IssueRowView(issue: issue)
            }
            .onDelete(perform: viewModel.delete)
        }
        .navigationTitle("Issues")
        .searchable(
            text: $viewModel.filterText,
            tokens: $viewModel.filterTokens,
            suggestedTokens: .constant(
                viewModel.suggestedFilterTokens
            ),
            prompt: "Filter issues, or type # to add tags"
        ) { tag in
            Text(
                tag.tagName
            )
        }
        .toolbar(content: ContentViewToolbar.init)
        .onAppear(perform: askForReview)
        .onOpenURL(perform: openURL)
    }
   
    init(dataController: DataController) {
        let viewModel = ViewModel(dataController: dataController)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    func askForReview() {
        if viewModel.shouldRequestReview {
            requestReview()
        }
    }
    
    func openURL(_ url: URL) {
        if url.absoluteString.contains("newIssue") {
            viewModel.dataController.newIssue()
        }
    }
}

#Preview {
    ContentView(dataController: .preview)
}
