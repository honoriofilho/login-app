//
//  CreatPostView.swift
//  Login
//
//  Created by honorio on 26/08/24.
//

import SwiftUI

struct CreatPostView: View {
    
    @State private var text: String = ""
    @StateObject private var viewModel = PostViewModel()
    
    var body: some View {
            VStack(spacing: 20) {
                TextField("Digite alguma coisa", text: $text)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                Button {
                    Task {
                        await viewModel.cretePost(text: text, username: "cauan")
                    }
                } label: {
                    Text("Tweetar")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(40.0)
            .navigationTitle("Criar Post")
    }
}

#Preview {
    CreatPostView()
}
