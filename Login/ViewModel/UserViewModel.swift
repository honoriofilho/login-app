//
//  UserController.swift
//  Login
//
//  Created by honorio on 22/08/24.
//

import Foundation
import SwiftUI

@MainActor
class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    let baseURL = URL(string: "http://maionese.local:8080")!

    private let userService = UserService()
    private let keychain = KeychainManager()
    private let service = "com.login.app"
        
    func fetchUsers() async {
        do{
            let fetchedUsers = try await userService.getUsers(on: baseURL)
            users = fetchedUsers ?? []
        }catch {
            print("Falha ao carregar Usuários")
        }
    }
    
    func createUsers(username: String, name: String, password: String) async {
        do {
            let session = try await userService.createUser(on: baseURL, username: username, name: name, password: password)
            let data = session.data(using: .utf8)!
            if keychain.storeData(data: data, forService: service, account: username) {
                print("Token salvo no Keychain")
            } else {
                print("Falha ao salvar token no Keychain")
            }
            print(session)
        } catch {
            print("Erro ao criar usuário!")
        }
    }
    
    func loginUser(username: String, password: String) async {
        do {
            let session = try await userService.login(on: baseURL, username: username, password: password)
            let data = session.data(using: .utf8)!
            if keychain.storeData(data: data, forService: service, account: username) {
                print("Token salvo no Keychain")
            } else {
                print("Falha ao salvar token no Keychain")
            }
            if let retrievedData = keychain.readData(forService: service, account: username) {
                let session = String(data: retrievedData, encoding: .utf8)
            }
            print(session)
            Task {
                await updateBio(token: session, bio: "Miau")
            }
        } catch {
            print("Erro ao fazer login: \(error.localizedDescription)")
        }
    }
    
    func updateBio(token: String, bio: String) async {
        do {
            _ = try await userService.updateBio(on: baseURL, token: token , bio: bio)
        } catch {
            print("Erro ao atualizar BIO")
        }
    }
}
