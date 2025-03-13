//
//  AsyncLetModule.swift
//  Concurrency
//
//  Created by Dominic Montalto on 13/03/2025.
//

import SwiftUI

struct UserStats {
    let posts: Int
    let followers: Int
    let following: Int
}

@MainActor
class AsyncLetViewModel: ObservableObject {
    @Published var stats: UserStats?
    
    func fetchStats() async {
        print("Function started..")
        async let posts = fetchPostsCount()  // 3 secs
        async let followers = fetchFollowersCount()  // 2
        async let following = fetchFollowingCount()  // 1 -> 6 seconds
        print("Function continuing on after async operations..")
        self.stats = await UserStats(posts: posts, followers: followers, following: following)
        print("Updated stats..")
    }
    
    private func fetchPostsCount() async -> Int {
        print("Fetching posts...")
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        print("Got posts")
        return 9
    }
    
    private func fetchFollowersCount() async -> Int {
        print("Fetching followers...")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        print("Got followers")
        return 20
    }
    
    private func fetchFollowingCount() async -> Int {
        print("Fetching following...")
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        print("Got following")
        return 1
    }
}

struct AsyncLetModule: View {
    @StateObject var viewModel = AsyncLetViewModel()
    
    var body: some View {
        HStack {
            if let stats = viewModel.stats {
                VStack {
                    Text("\(stats.posts)")
                    Text("Posts")
                }
                .frame(width: 100)
                
                VStack {
                    Text("\(stats.followers)")
                    Text("Followers")
                }
                .frame(width: 100)
                
                VStack {
                    Text("\(stats.following)")
                    Text("Following")
                }
                .frame(width: 100)
            } else {
                ProgressView()
            }
        }
        .task { await viewModel.fetchStats() }
    }
}

#Preview {
    AsyncLetModule()
}
