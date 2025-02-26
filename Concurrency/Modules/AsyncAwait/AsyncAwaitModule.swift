//
//  AsyncAwaitModule.swift
//  Concurrency
//
//  Created by Dominic Montalto on 26/02/2025.
//

import SwiftUI

/*
 1. async func requires use of await when called
 2. async func cannot be called from a sync context
 3. use Task {...} to run async code
*/

struct AsyncAwaitModule: View {
    @StateObject var viewModel = AsyncAwaitViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                } else {
                    List {
                        ForEach(viewModel.users) { user in
                            VStack(alignment: .leading) {
                                Text(user.username)
                                
                                if viewModel.isUpdating {
                                    ProgressView()
                                } else {
                                    Text(user.email)
                                }
                            }
                        }
                    }
                }
            }
            
            Button("Update Emails") {
                Task { await viewModel.updateUserEmails() }
            }
        }
    }
}

#Preview {
    AsyncAwaitModule()
}
