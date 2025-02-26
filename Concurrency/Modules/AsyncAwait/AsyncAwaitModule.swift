//
//  AsyncAwaitModule.swift
//  Concurrency
//
//  Created by Dominic Montalto on 26/02/2025.
//

import SwiftUI

struct User: Identifiable {
    let name: String
    var email: String
    
    var id = UUID().uuidString
}

class AsyncAwaitViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task { await fetchData() }
    }
    
    func fetchData() async {
        let users: [User] = [
            .init(name: "John Doe", email: "john@gmail.com"),
            .init(name: "Kelly Johnson", email: "kelly@gmail.com"),
            .init(name: "Ted Smith", email: "ted@gmail.com")
        ]
        
        self.users = users
    }
    
    func updateUserEmails() async -> [User] {
        var result = [User]()
        
        for user in users {
            let newEmail = user.email.replacingOccurrences(of: "gmail", with: "appstuff")
            let newUser = User(name: user.name, email: newEmail)
            result.append(newUser)
        }
        
        return result
    }
}

struct AsyncAwaitModule: View {
    
    @StateObject private var viewModel = AsyncAwaitViewModel()
    
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.users) { user in
                    VStack(alignment: .leading) {
                        Text(user.name)
                        Text(user.email)
                    }
                }
            }
        }
    }
}

#Preview {
    AsyncAwaitModule()
}
