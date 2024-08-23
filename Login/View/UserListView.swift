//
//  UserListView.swift
//  Login
//
//  Created by honorio on 23/08/24.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel = UserViewModel()
    
    var body: some View {
        List(viewModel.users, id: \.id) { user in
            Text(user.name)
        }
        .onAppear {
            Task {
                await viewModel.fetchUsers()
            }
        }
    }
}

#Preview {
    UserListView()
}
