//
//  ContentViewModel.swift
//  UltimatePortfolio_AH
//
//  Created by Andy Heredia on 11/9/25.
//

import Foundation

extension ContentView {
    @dynamicMemberLookup
    class ViewModel: ObservableObject {
        var dataController: DataController
        
        init(dataController: DataController) {
            self.dataController = dataController
        }
        
        subscript<Value>(dynamicMember keyPath: KeyPath<DataController, Value>) -> Value {
            dataController[keyPath: keyPath]
        }
        
        subscript<Value>(dynamicMember keyPath: ReferenceWritableKeyPath<DataController, Value>) -> Value {
            get { dataController[keyPath: keyPath] }
            set { dataController[keyPath: keyPath] = newValue }
        }
        
        func delete(_ offsets: IndexSet) {
            
            let issues = dataController.issuesForSelectedFilter()
            
            for offset in offsets { // índices a borrar (de onDelete)
                let item = issues[offset] // obtiene el Tag en ese índice
                dataController.delete(item) // elimina en Core Data y guarda
            }
        }
        
    }
}
