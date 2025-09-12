//
//  Issue-CoreDataHelpers.swift
//  UltimatePortfolio_AH
//
//  Created by Andy Heredia on 19/8/25.
//

import Foundation

extension Issue {
    
    var issueTitle: String {
        get { title ?? "" }
        set { title = newValue }
    }
    
    var issueContent: String {
        get { content ?? "" }
        set { content = newValue }
    }
    
    var issueCreationDate: Date {
        creationDate ?? .now
    }
    
    var issueModificationDate: Date {
        modificationDate ?? .now
    }
    
    // NSSet Creo que aqui añadimos la relacion que tiene issues con tags
    var issueTags: [Tag] {
        let result = tags?.allObjects as? [Tag] ?? []
        return result.sorted()
    }
    
    var issueTagsList: String {
        let noTags = NSLocalizedString("No tags", comment: "The user has not created any tags yet.")
        guard let tags else { return noTags }
        
        if tags.count == 0 {
            return noTags
        } else {
            return issueTags.map(\.tagName).formatted()
        }
    }
    
    var issueStatus: String {
        if completed {
            return NSLocalizedString("Closed", comment: "This issue has been resolved by the user.")
        } else {
            return NSLocalizedString("Open", comment: "This issue is currently unresolved.")
        }
    }
    
    var issueFormattedCreationDate: String {
        issueCreationDate.formatted(date: .numeric, time: .omitted)
    }
    
    static var example: Issue {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        let issue = Issue(context: viewContext)
        issue.title = "Example Issue"
        issue.content = "This is an example issue."
        issue.priority = 2
        issue.creationDate = .now
        return issue
    }
    
}

extension Issue: Comparable {
    public static func <(lhs: Issue, rhs: Issue) -> Bool {
        // Compara los títulos en minúsculas
        let left = lhs.issueTitle.localizedLowercase
        let right = rhs.issueTitle.localizedLowercase

        if left == right {
            // Si los títulos son iguales, ordena por fecha de creación
            return lhs.issueCreationDate < rhs.issueCreationDate
        } else {
            // Si los títulos son distintos, ordena alfabéticamente
            return left < right
        }
    }
}
