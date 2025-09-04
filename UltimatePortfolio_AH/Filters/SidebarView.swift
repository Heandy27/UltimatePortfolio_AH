//
//  SidebarView.swift
//  UltimatePortfolio_AH
//
//  Created by Andy Heredia on 19/8/25.
//

import SwiftUI

struct SidebarView: View {
    
    @EnvironmentObject var dataController: DataController
    let smartFilters: [Filter] = [.all, .recent]
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var tags: FetchedResults<Tag>
    
    @State private var tagToRename: Tag?
    @State private var renamingTag = false
    @State private var tagName = ""
    
    
    
    var tagFilters: [Filter] {
        tags.map { tag in
            Filter(id: tag.tagID, name: tag.tagName, icon: "tag", tag: tag)
        }
    }
    
    var body: some View {
        List(selection: $dataController.selectedFilter) {
            Section("Smart Filters") {
                ForEach(smartFilters, content: SmartFilterRowView.init)
            }
            
            Section("Tags") {
                ForEach(tagFilters) { filter in
                  UserFilterRowView(filter: filter, rename: rename, delete: delete)
                }
                .onDelete(perform: delete)
            }
        }
        .toolbar(content: SideBarViewToolbar.init)
        .alert("Rename tag", isPresented: $renamingTag) {
            Button("OK", action: completeRename)
            Button("Cancel", role: .cancel) { }
            TextField("New name", text: $tagName)
        }
       
        .navigationTitle("Filters")
    }
    
    
    func delete(_ offsets: IndexSet) {
        for offset in offsets { // índices a borrar (de onDelete)
            let item = tags[offset] // obtiene el Tag en ese índice
            dataController.delete(item) // elimina en Core Data y guarda
        }
    }
    
    
    func delete(_ filter: Filter) {
        guard let tag = filter.tag else { return }
        dataController.delete(tag)
        dataController.save()
    }
    
    func rename(_ filter: Filter) {
        tagToRename = filter.tag
        tagName = filter.name
        renamingTag = true
    }
    
    func completeRename() {
        tagToRename?.name = tagName
        dataController.save()
    }
}

#Preview {
    SidebarView()
        .environmentObject(DataController.preview)
}
