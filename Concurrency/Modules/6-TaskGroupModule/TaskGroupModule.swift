//
//  TaskGroupModule.swift
//  Concurrency
//
//  Created by Dominic Montalto on 17/03/2025.
//

import SwiftUI

@MainActor
class TaskGroupViewModel: ObservableObject {
    @Published var products = [Product]()
    
    private let productService = ProductService()
    private let userService = UserService()

    func fetchProducts() async {
        print("Fetching products..") // 1
        do {
            self.products = try await productService.fetchProducts()
            print("Product fetch complete..") // 2
            try await fetchProductOwnersWithTaskGroup()
        } catch {
            print("Failed to fetch prodcuts")
        }
    }
    
    func fetchProductOwners() async {
        do {
            for product in products {
                let user = try await userService.fetchUser(product.id)
                let index = product.id - 1
                products[index].productOwner = user
            }
        } catch {
            print("Failed to fetch users for products")
        }
    }
    
    func fetchProductOwnersWithTaskGroup() async throws {
        print("Entered task group function..") // 3
        try await withThrowingTaskGroup(of: User.self) { group in
            for product in products {
                print("Product in loop is \(product.id)")
                group.addTask {
                    let user = try await self.userService.fetchUser(product.id)
                    print("Got user back in task group: \(user.id)")
                    return user
                }
            }
            
            print("Finished looping thru products")
            
            for try await user in group {
                print("User id in task group async loop: \(user.id)")
                updateProducts(user)
            }
            
            print("Finished user task group..")
        }
    }
    
    func updateProducts(_ user: User) {
        let index = user.id - 1
        self.products[index].productOwner = user
    }
}

struct TaskGroupModule: View {
    @StateObject var viewModel = TaskGroupViewModel()
    
//    @StateObject var productsViewModel = ProductsViewModel(service: ProductService())
//    @StateObject var usersViewModel = UsersViewModel(service: UserService())

    var body: some View {
        List {
            Section("Products") {
                ForEach(viewModel.products) { product in
                    HStack(spacing: 16) {
                        Text("\(product.id)")
                        VStack(alignment: .leading) {
                            if let owner = product.productOwner {
                                Text(owner.username)
                            }
                            
                            Text(product.title)
                                .lineLimit(1)
                            
                            Text("$\(product.price)")
                                .foregroundStyle(.gray)
                                .font(.footnote)
                        }
                    }
                    .font(.subheadline)
                }
            }
            
//            Section("Users") {
//                ForEach(usersViewModel.users) { user in
//                    Text(user.username)
//                }
//            }
        }
        .task { await viewModel.fetchProducts() }
//        .task { await usersViewModel.fetchUsers() }
    }
}

#Preview {
    TaskGroupModule()
}
