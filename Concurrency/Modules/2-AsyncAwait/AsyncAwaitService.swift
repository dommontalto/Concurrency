//
//  AsyncAwaitService.swift
//  Concurrency
//
//  Created by Dominic Montalto on 26/02/2025.
//

import Foundation

class AsyncAwaitService {
    func fetchUsers() async throws -> [User] {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        let throwError = false
        
        if throwError {
            throw URLError(.badURL)
        } else {
            let users: [User] = [
                .init(username: "John Doe", email: "john@gmail.com", id: 1),
                .init(username: "Kelly Johnson", email: "kelly@gmail.com", id: 2),
                .init(username: "Ted Smith", email: "ted@gmail.com", id: 3),
            ]
            
            return users
        }
    }
        
    func fetchUsersWithCompletion(completion: @escaping(Result<[User], Error>) -> Void) {
        let users: [User] = [
            .init(username: "John Doe", email: "john@gmail.com", id: 1),
            .init(username: "Kelly Johnson", email: "kelly@gmail.com", id: 2),
            .init(username: "Ted Smith", email: "ted@gmail.com", id: 3),

        ]
        
        let throwError = Bool.random()
        
        if throwError {
            completion(.failure(URLError(.badURL)))
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                completion(.success(users))
            }
        }
    }
}
