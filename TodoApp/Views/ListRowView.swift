//
//  ListRowView.swift
//  TodoApp
//
//  Created by Deniz Can on 27.05.2022.
//

import SwiftUI

struct ListRowView: View {
    
    let title: String
    let isCompleted: Bool
    
    var body: some View {
        HStack {
            Image(systemName: isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(isCompleted ? .green : .red)
            Text(title)
            Spacer()
        }.font(.title2)
            .padding(.vertical, 8)
    }
}


struct ListRowView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            ListRowView(title: "RandomTitle", isCompleted: true)
            ListRowView(title: "Revenge of the random title", isCompleted: false)
        }.previewLayout(.sizeThatFits)
    }
}
