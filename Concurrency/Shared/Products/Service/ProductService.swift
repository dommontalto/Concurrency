//
//  ProductService.swift
//  Concurrency
//
//  Created by Dominic Montalto on 14/03/2025.
//

import Foundation

struct ProductService {
    func fetchProducts() async throws -> [Product] {
        var result = [Product]()
    
        for i in 1 ... 5 {
            let url = URL(string: "https://fakestoreapi.com/products/\(i)")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let product = try JSONDecoder().decode(Product.self, from: data)
            result.append(product)
        }
        
        return result
    }
}
