//
//  LoginView.swift
//  Login
//
//  Created by honorio on 23/08/24.
//

import SwiftUI

struct LoginView: View {
    
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.semibold)
            TextField("Username", text: $username)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            TextField("Password", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            Button {
                
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
