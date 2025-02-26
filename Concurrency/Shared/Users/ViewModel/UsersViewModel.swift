//
//  UsersViewModel.swift
//  Concurrency
//
//  Created by Dominic Montalto on 26/02/2025.
//

import Foundation

class UsersViewModel: ObservableObject {
    @Published var users = [User]()
    
    private let service: UserService
    
    init(service: UserService) {
        self.service = service
    }
    
    func fetchUsers() async {
        do {
            self.users = try await service.fetchAllUsers()
        } catch {
            print("Failed to fetch users with error: \(error)")
        }
    }
    
    func fetchUser(_ id: Int) async {
        do {
            
        } catch {
            
        }
    }
}
