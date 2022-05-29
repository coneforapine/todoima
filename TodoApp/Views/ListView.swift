//
//  ListView.swift
//  TodoApp
//
//  Created by Deniz Can on 27.05.2022.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        VStack {
            if listViewModel.items.count != 0 {
                List {
                    ForEach(listViewModel.items) { item in
                        let _ = print(item)
                        ListRowView(title: item.title ?? "unknown"
                                    , isCompleted: item.isCompleted)
                        .onTapGesture {
                            listViewModel.toggleStatus(ofItem: item)
                        }
                    }
                    .onDelete(perform: listViewModel.onDelete)
                    .onMove(perform: listViewModel.onMove)
                    .listStyle(.plain)
                }.listStyle(PlainListStyle())
            } else {
                Text("You don't have any todos added")
                NavigationLink("Add TODO's", destination: AddView())
            }
        }
        .navigationTitle("Todoima List 📝")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationLink("Add", destination: AddView())
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
    }

}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }.environmentObject(ListViewModel())
    }
}
