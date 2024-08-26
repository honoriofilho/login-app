//
//  LoginView.swift
//  Login
//
//  Created by honorio on 23/08/24.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel = UserViewModel()
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.semibold)
            TextField("Username", text: $username)
                .autocapitalization(.none)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            TextField("Password", text: $password)
                .autocapitalization(.none)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            Button {
                Task {
                    await viewModel.loginUser(username: username, password: password)
                }
            } label: {
                Text("Login")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(40.0)
    }
}

#Preview {
    LoginView()
}
