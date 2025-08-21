//
//  NoIssueView.swift
//  UltimatePortfolio_AH
//
//  Created by Andy Heredia on 21/8/25.
//

import SwiftUI

struct NoIssueView: View {
    
    @EnvironmentObject var dataController: DataController
    var body: some View {
        Text("No Issue Selected")
            .font(.title)
            .foregroundStyle(.secondary)
        Button("New Issue") {
            // Make a new Issue
        }
    }
}

#Preview {
    NoIssueView()
}
