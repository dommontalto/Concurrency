//
//  ProductsViewModel.swift
//  Concurrency
//
//  Created by Dominic Montalto on 14/03/2025.
//

import Foundation

class ProductsViewModel: ObservableObject {
    @Published var products: [Product] = []
    
    private let service: ProductService
    
    init(service: ProductService) {
        self.service = service
    }
    
    func fetchProducts() async {
        do {
            products = try await service.fetchProducts()
        } catch {
            print("Failed to fetch products with error: \(error)")
        }
    }
 
}
