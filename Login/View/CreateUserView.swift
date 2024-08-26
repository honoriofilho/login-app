//
//  CreateUserView.swift
//  Login
//
//  Created by honorio on 23/08/24.
//

import SwiftUI

struct CreateUserView: View {
    
    @StateObject private var viewModel = UserViewModel()
    @State var username: String = ""
    @State var name: String = ""
    @State var password: String = ""
    
    var body: some View {
            VStack(spacing: 20) {
                Text("Criar Usuário")
                    .font(.largeTitle)
                    .fontWeight(.semibold)

                TextField("Username", text: $username)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                // Campo de Name
                TextField("Name", text: $name)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)

                // Campo de Password
                SecureField("Password", text: $password)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                Button  {
                    Task {
                        await viewModel.createUsers(username: username, name: name, password: password)
                    }
                } label: {
                    Text("Salvar")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(40.0)
    }
}
