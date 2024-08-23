//
//  UserService.swift
//  Login
//
//  Created by honorio on 22/08/24.
//

import Foundation

enum UserServiceError: Error {
    case InvalidURL
    case InvalidResponse
    case decodingError
}

struct UserService {
    func getUsers() async throws -> [User]? {
        
        let urlString = "http://maionese.local:8080"
        
        guard let baseURL = URL(string: urlString) else {
            throw UserServiceError.InvalidURL
        }
        
        let url = baseURL.appending(path: "users")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard response is HTTPURLResponse else {
            throw UserServiceError.InvalidResponse
        }
        
        do {
            let users = try JSONDecoder().decode([User].self, from: data)
            return users
        } catch {
            throw UserServiceError.decodingError
        }
    }
    
    func createUser(username: String, name: String, password: String) async throws {
        
        let urlString = "http://maionese.local:8080"
        
        guard let baseURL = URL(string: urlString) else {
            throw UserServiceError.InvalidURL
        }
        
        let url = baseURL.appending(path: "users")
        
        let create = User.Create(username: username, name: name, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(create)
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json"
        ]
        
        let (data, response) = try await URLSession.shared.data(for: request)
    }
}
