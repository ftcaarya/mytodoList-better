//
//  HomeTabView.swift
//  mytodolist
//
//  Created by Saravanan Saminathan on 7/4/24.
//

import SwiftUI

struct HomeTabView: View {
    @State  var selectedIndex: Int = 0
    
    var body: some View {
            TabView(selection: $selectedIndex) {
                TodoListView()
                    .tabItem {
                            Label("TodoList", systemImage: "person.fill")
                        }.tag(0)
                
                ProfileView()
                .tabItem {
                        Label("Account Info", systemImage: "person.fill")
                    }.tag(1)
            }
    }
}

#Preview {
    HomeTabView().environment(AppState())
}
