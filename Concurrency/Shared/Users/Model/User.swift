//
//  User.swift
//  Concurrency
//
//  Created by Dominic Montalto on 26/02/2025.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    let username: String
    var email: String
    
    let id: Int
}

