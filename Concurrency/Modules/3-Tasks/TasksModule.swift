//
//  TasksModule.swift
//  Concurrency
//
//  Created by Dominic Montalto on 11/03/2025.
//

import SwiftUI

struct TasksModule: View {
    @StateObject var viewModel = AsyncAwaitViewModel()
    @State private var selectedUserId: String?
    @State private var didExecuteTask = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.users) { user in
                        NavigationLink(value: user, label: {
                            VStack(alignment: .leading) {
                                Text(user.username)
                                
                                if viewModel.isUpdating {
                                    ProgressView()
                                } else {
                                    Text(user.email)
                                }
                            }
                        })
//                        .onTapGesture {
//                            selectedUserId = user.id
//                        }
                    }
                }
            }
            .task(id: selectedUserId) {
                print("Update user email now: \(selectedUserId ?? "")")
            }
            .task {
                guard !didExecuteTask else {
                    print("Task already ran..")
                    return
                }
                print("Running fetch data task..")
                await viewModel.fetchData()
                didExecuteTask = true
            }
            .navigationDestination(for: User.self, destination: { user in
                Text(user.username)
            })
        }
//        .onDisappear {
//            task?.cancel()
//        }
//        .onAppear {
//            self.task = Task(priority: .high) { // 1
//                print("Started task 1..")
//                await viewModel.fetchData()
//                // do some subsequent task..
//                print("Completed task 1..")
//                print("Users count \(viewModel.users.count)")
//            }
//
//            Task(priority: .low) { // 2
//                // await doSomething
//                print("Started task 2..")
//            }
//
//            Task(priority: .background) { // 3
//                // await doSomething
//                print("Started task 3..")
//            }
//        }
    }
}

#Preview {
    TasksModule()
}
