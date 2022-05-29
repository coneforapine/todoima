//
//  AddView.swift
//  TodoApp
//
//  Created by Deniz Can on 28.05.2022.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    
    // I can't seem to use color literal as a parameter down there... Kthx apple.
    let fieldBackgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    
    @State var todoTitleField: String = ""
    @State var showAlert: Bool = false
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                TextField("Title", text: $todoTitleField)
                    .frame(height: 40)
                    .padding(.horizontal)
                    .background(Color(fieldBackgroundColor))
                    .cornerRadius(10)

                Button(action: onSavePressed, label: {
                        Text("Save".uppercased())
                    }
                )
            
            }.padding(14)
        }.padding(.horizontal)
        .navigationTitle("Add an item ✍🏻")
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("You need to add 3 or more characters to create a todo"))
        })
    }
    
    func onSavePressed() {
        if todoTitleField.count >= 3 {
            listViewModel.createItem(title: todoTitleField)
            // Isn't this a little bit weird to dismiss / go back a screen?
            presentationMode.wrappedValue.dismiss()
        } else {
            showAlert.toggle()
        }
    }
    
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddView()
        }.environmentObject(ListViewModel())
    }
}
