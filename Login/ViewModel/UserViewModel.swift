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

    private let userService = UserService()
        
    func fetchUsers() async {
        do{
            let fetchedUsers = try await userService.getUsers()
            users = fetchedUsers ?? []
        }catch {
            print("Falha ao carregar Usuários")
        }
    }
    
    func createUsers(username: String, name: String, password: String) async {
        do {
            _ = try await userService.createUser(username: username, name: name, password: password)
        } catch {
            print("Erro ao criar usuário!")
        }
    }
}
