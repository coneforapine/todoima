//
//  ListViewModel.swift
//  TodoApp
//
//  Created by Deniz Can on 29.05.2022.
//

import Foundation
import CoreData
import UIKit

class ListViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var items: [TodoItem] = []
    
    init() {
        container = NSPersistentContainer(name: "TodoItem")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
        getData()
    }
    
    func getData() {
        let request = NSFetchRequest<TodoItem>(entityName: "TodoItem")
        
        do {
            try items = container.viewContext.fetch(request)
        } catch {
            print("Error getting data. \(error.localizedDescription)")
        }
    }
    
    func createItem(title: String) -> Void {
        let newItem = TodoItem(context: container.viewContext)
        newItem.id = UUID()
        newItem.title = title
        newItem.isCompleted = false
        // this method updates the state array as well
        saveData()
    }
    
    func toggleStatus(ofItem: TodoItem) {
        let request = TodoItem.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", ofItem.id! as CVarArg)
        var items: [TodoItem]
        
        do {
            items = try! container.viewContext.fetch(request)
            if let item = items.first {
                item.isCompleted.toggle()
                saveData()
            }
        
        }
    }
    
    func onMove(source: IndexSet, destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }
    
    func onDelete(indexes: IndexSet) {
        
        indexes.forEach { idx in
            container.viewContext.delete(items[idx])
        }
        
        items.remove(atOffsets: indexes)
        getData()
    }

    
    private func saveData() {
        do {
               try container.viewContext.save()
               getData()
            //to update the published variable to reflect this change
           } catch let error {
               print("Error: \(error.localizedDescription)")
           }
    }
    
}
