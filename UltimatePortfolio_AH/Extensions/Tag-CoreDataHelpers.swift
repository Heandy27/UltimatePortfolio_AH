//
//  Tag-CoreDataHelpers.swift
//  UltimatePortfolio_AH
//
//  Created by Andy Heredia on 19/8/25.
//

import Foundation

extension Tag {
    
    var tagID: UUID {
        id ?? UUID()
    }
    
    var tagName: String {
        name ?? ""
    }
    
    // Aquí va la relacion NSSet
    var tagActiveIssues: [Issue] {
        let result = issues?.allObjects as? [Issue] ?? []
        return result.filter { $0.completed == false }
    }
    
    static var example: Tag {
        let controller = DataController(inMemory: true)
        let viewConext = controller.container.viewContext
        
        let tag = Tag(context: viewConext)
        tag.id = UUID()
        tag.name = "Example Tag"
        return tag
    }
}

extension Tag: Comparable {
    public static func < (lhs: Tag, rhs: Tag) -> Bool {
        // Compara los nombres en minúsculas
        let left = lhs.tagName.localizedLowercase
        let right = rhs.tagName.localizedLowercase
        
        if left == right {
            // Si los nombres son iguales, ordena por el UUID
            return lhs.tagID.uuidString < rhs.tagID.uuidString
        } else {
            // Si los nombres son distintos, ordena alfabéticamente
            return left < right
        }
    }
}
