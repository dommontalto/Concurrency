//
//  TasksModule.swift
//  Concurrency
//
//  Created by Dominic Montalto on 11/03/2025.
//

import SwiftUI

struct TasksModule: View {
    @StateObject var viewModel = AsyncAwaitViewModel()
    @State private var task: Task<(), any Error>?
    
    var body: some View {
        VStack {
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
        .onDisappear() {
            self.task?.cancel()
        }
        .onAppear() {
            self.task = Task(priority: .high){
                print("Started High Priority Task")
                await viewModel.fetchData()
                print("Finished High Priority Task")
            }
            
            Task(priority: .low){
                print("Started Low Priority Task")
//                await viewModel.fetchData()
            }
            
            Task(priority: .background){
                print("Started Background Priority Task")
//                await viewModel.fetchData()
            }
        }
    }
}

#Preview {
    TasksModule()
}
