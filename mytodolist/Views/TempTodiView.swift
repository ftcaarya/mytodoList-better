//
//  TempTodiView.swift
//  mytodolist
//
//  Created by Saravanan Saminathan on 7/9/24.
//

import SwiftUI

struct TempTodiView: View {
    var body: some View {
        NavigationView {
            VStack {
                
            }
            .navigationTitle("To Do List")
            .toolbar {
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    TempTodiView()
}
