//
//  DataController-Awards.swift
//  UltimatePortfolio_AH
//
//  Created by Andy Heredia on 29/9/25.
//

import Foundation
import CoreData

extension DataController {
    
    func hasEarned(award: Award) -> Bool {
        switch award.criterion {
        case "issues":
            // return true if they added a certain number of issues
            let fetchRequest = Issue.fetchRequest()
            let awardCount = count(for: fetchRequest)
            return awardCount >= award.value
        case "closed":
            // return true if they closed a certain number of issues
            let fetchRequest = Issue.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "completed = true")
            let awardCount = count(for: fetchRequest)
            return awardCount >= award.value
        case "tags":
            // return true if they created a certain number of tags
            let fetchRequest = Tag.fetchRequest()
            let awardCount = count(for: fetchRequest)
            return awardCount >= award.value
            
        case "unlock":
            return fullVersionUnlocked
            
        default:
            // An unkown award criterion; this should never be allowed
            //fatalError("Unkown award criterion")
            return false
        }
    }
}
