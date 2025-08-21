//
//  ContentView.swift
//  UltimatePortfolio_AH
//
//  Created by Andy Heredia on 18/8/25.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var dataController: DataController
    
    
    // Propiedad calculada: devuelve issues filtrados de Core Data
    var issues: [Issue] {
       
        let filter = dataController.selectedFilter ?? .all // Filtro actual o "all"
        // Se declara un array temporal para guardar los issues que se van a obtener.
        var allIssues: [Issue]
        
        if let tag = filter.tag {
            // tag.issues?.allObjects convierte el conjunto (NSSet) de issues en un array.
            allIssues = tag.issues?.allObjects as? [Issue] ?? [] // Issues por tag
        } else {
            /*
             Si el filtro no tiene un tag
             Se crea una fetchRequest() para pedir todos los issues en Core Data.
             try? ... hace el fetch, y si falla devuelve [].
             */
            let request = Issue.fetchRequest() // Todos los issues
            // Solo tráeme los registros cuya modificationDate sea posterior a la fecha mínima definida en el filtro.
            request.predicate = NSPredicate(format: "modificationDate > %@", filter.minModificationDate as NSDate)
            allIssues = (try? dataController.container.viewContext.fetch(request)) ?? []
        }
        
        // Siempre los devuelve ordenados con .sorted().
        return allIssues.sorted()
    }
    
    var body: some View {
        List(selection: $dataController.selectedIssue) {
            ForEach(issues) { issue in
                IssueRowView(issue: issue)
            }
            .onDelete(perform: delete)
        }
        .navigationTitle("Issues")
    }
    func delete(_ offsets: IndexSet) {
        for offset in offsets { // índices a borrar (de onDelete)
            let item = issues[offset] // obtiene el Tag en ese índice
            dataController.delete(item) // elimina en Core Data y guarda
        }
    }
}

#Preview {
    ContentView()
}
