//
//  ImagePostView.swift
//  Login
//
//  Created by honorio on 27/08/24.
//

import SwiftUI

struct ImagePostView: View {
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented = false
    @State private var postResult: String = ""

    var body: some View {
        VStack {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .padding()
            } else {
                Text("Selecione uma imagem")
                    .padding()
            }
            
            Button("Escolher Imagem") {
                isImagePickerPresented.toggle()
            }
            .padding()

            Button("Enviar Imagem") {
                Task {
//                    do {
//                        try await createImagePost(on: URL(string: "https://api.example.com/")!, with: "yourTokenHere")
//                        postResult = "Imagem enviada com sucesso!"
//                    } catch {
//                        postResult = "Erro ao enviar a imagem: \(error.localizedDescription)"
//                    }
                }
            }
            .padding()

            Text(postResult)
                .padding()
        }
        .sheet(isPresented: $isImagePickerPresented) {
//            ImagePicker(image: $selectedImage)
        }
    }
}


#Preview {
    ImagePostView()
}
