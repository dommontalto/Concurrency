//
//  Product.swift
//  Concurrency
//
//  Created by Dominic Montalto on 14/03/2025.
//

import Foundation

struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let image: String
    
    var productOwner: User?
}
