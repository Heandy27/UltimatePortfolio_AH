//
//  IssueRowWatch.swift
//  UPAWatch Watch App
//
//  Created by Andy Heredia on 2/10/25.
//

import SwiftUI

struct IssueRowWatch: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var issue: Issue
    var body: some View {
        NavigationLink(value: issue) {
            HStack {
                VStack(alignment: .leading) {
                    Text(issue.issueTitle)
                        .font(.headline)
                        .lineLimit(1)
                    
                    Text(issue.issueCreationDate.formatted(date: .numeric, time: .omitted))
                        .font(.subheadline)
                }
                .foregroundStyle(issue.completed ? .secondary : .primary)
            }
        }
    }
}

#Preview {
    IssueRowWatch(issue: .example)
}
