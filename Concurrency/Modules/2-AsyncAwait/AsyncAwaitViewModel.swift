//
//  AsyncAwaitViewModel.swift
//  Concurrency
//
//  Created by Dominic Montalto on 26/02/2025.
//

import Foundation

@MainActor
class AsyncAwaitViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var isLoading = false
    @Published var isUpdating = false
    @Published var errorMessage: String?
    
    private let service = AsyncAwaitService()
    
    init() {
//        Task {
//            await fetchData()
//        }
        
        print("Fetching users") // 1
//        fetchDataWithCompletion()
    }
    
    func fetchData() async {
        do {
            isLoading = true
            self.users = try await service.fetchUsers()
            print("Succesful task completion..")
            isLoading = false
        } catch {
            isLoading = false
            self.errorMessage = "An error ocurred"
            print("Failed to fetch users with error: \(error)")
        }
    }
    
    func fetchDataWithCompletion() {
        service.fetchUsersWithCompletion { result in
            switch result {
            case .success(let users):
                // handle success
                self.users = users
            case .failure(let failure):
                // handle error
                self.errorMessage = failure.localizedDescription
            }
        }
        
        print("Did reach end of function") // 2
    }
    
    func updateUserEmails() async {
        var result = [User]()
        isUpdating = true
        
        if users.isEmpty {
            print("No users")
        }
        
        try? await Task.sleep(nanoseconds: 1_000_000_000)

        for user in users {
            let newEmail = user.email.replacingOccurrences(of: "gmail", with: "appstuff")
            let newUser = User(username: user.username, email: newEmail, id: user.id)
            result.append(newUser)
        }
        
        isUpdating = false
        
        self.users = result
    }
}
