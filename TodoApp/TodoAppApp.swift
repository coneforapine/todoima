//
//  TodoAppApp.swift
//  TodoApp
//
//  Created by Deniz Can on 27.05.2022.
//

import SwiftUI

@main
struct TodoAppApp: App {
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
            .environmentObject(listViewModel)
        }
    }
}
