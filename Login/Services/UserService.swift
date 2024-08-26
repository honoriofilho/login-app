//
//  UserService.swift
//  Login
//
//  Created by honorio on 22/08/24.
//

import Foundation

enum UserServiceError: Error {
    case InvalidURL
    case InvalidResponsecase(code: Int, body: Data?)
    case decodingError
}

struct UserService {
    func getUsers(on baseURL: URL) async throws -> [User]? {
                
        let url = baseURL.appending(path: "users")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        try checkConection(data: data, response: response)
        
        do {
            let users = try JSONDecoder().decode([User].self, from: data)
            return users
        } catch {
            throw UserServiceError.decodingError
        }
    }
    
    func updateBio(on baseURL: URL, token: String, bio: String) async throws {
        let url = baseURL.appending(path: "users/bio")
                
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("text/plain", forHTTPHeaderField: "Content-Type")
        request.httpBody = bio.data(using: .utf8)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        try checkConection(data: data, response: response)
    }
    
    func checkConection(data: Data?, response: URLResponse) throws {
        if let response = response as? HTTPURLResponse {
            switch response.statusCode {
            case 200..<300:
                print("😸 Sucesso! \(response.statusCode)")
            default:
                print("🙀 Erro \(response.statusCode)")
                throw UserServiceError.InvalidResponsecase(code: response.statusCode, body: data)
            }
        }
    }
    
    func createUser(on baseURL: URL, username: String, name: String, password: String) async throws -> String {
        
        let url = baseURL.appending(path: "users")
        
        let create = User.Create(username: username, name: name, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(create)
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json"
        ]
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        try checkConection(data: data, response: response)
        
        let session = try JSONDecoder().decode(Session.self, from: data)

        return session.token
    }
    
    func login(on baseURL: URL, username: String, password: String) async throws -> String {
        
        let url = baseURL.appending(path: "users/login")

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let auth = (username + ":" + password).data(using: .utf8)!.base64EncodedString()

        request.setValue("Basic \(auth)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, response) = try await URLSession.shared.data(for: request)
        
        try checkConection(data: data, response: response)

        let session = try JSONDecoder().decode(Session.self, from: data)

        return session.token
    }
}
