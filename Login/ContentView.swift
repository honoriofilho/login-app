//
//  ContentView.swift
//  Login
//
//  Created by honorio on 22/08/24.
//

import SwiftUI

struct ContentView: View {
        
    var body: some View {
        TabView {
            CreateUserView()
                .tabItem { Label("Criar Contato", systemImage: "person.fill.badge.plus")
                }
            UserListView()
                .tabItem {
                    Label("Contatos", systemImage: "person.fill")
                }
            LoginView()
                .tabItem { Label("Login", systemImage: "globe") }
        }
    }
}

#Preview {
        ContentView()
}
