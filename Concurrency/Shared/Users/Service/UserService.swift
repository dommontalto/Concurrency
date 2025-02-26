//
//  UserService.swift
//  Concurrency
//
//  Created by Dominic Montalto on 26/02/2025.
//

import Foundation

struct UserService {
    func fetchAllUsers() async throws -> [User] {
        let url = URL(string: "https://fakestoreapi.com/users")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([User].self, from: data)
    }
    
    func fetchUser(_ id: Int) async throws -> User {
        let url = URL(string: "https://fakestoreapi.com/users/\(id)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let user = try JSONDecoder().decode(User.self, from: data)
        return user
    }
}
