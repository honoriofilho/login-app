//
//  PostView.swift
//  Login
//
//  Created by honorio on 26/08/24.
//

import SwiftUI
import UIKit

struct PostView: View {
    
    @StateObject private var viewModel = PostViewModel()
    let service = PostService()
    @State private var adicionarItem = false
    
    var body: some View {
        NavigationStack {
            List(viewModel.posts, id: \.id) { post in
                List(viewModel.posts, id: \.id) { post in
                    if let mediaString = post.media,
                       let image = service.convertBase64StringToImage(imageBase64String: mediaString) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200) // Exemplo de altura ajustável
                    }
                }
            }
            .refreshable {
                Task {
                    await viewModel.fetchPosts()
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchPosts()
                    await viewModel.createImagePost()
                }
            }
        }
        .toolbar {
            Button {
                adicionarItem = true
            } label: {
                Image(systemName: "plus.circle")
            }
        }
        .sheet(isPresented: $adicionarItem) {
            CreatPostView()
        }
    }
}

#Preview {
    NavigationStack {
        PostView()
            .navigationTitle("Feed")
    }
}
