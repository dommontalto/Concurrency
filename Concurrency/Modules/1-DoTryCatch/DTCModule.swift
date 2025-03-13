//
//  DTCModule.swift
//  Concurrency
//
//  Created by Dominic Montalto on 25/02/2025.
//

import SwiftUI

/*
 A throwing function requires the use of try when called
 Try requires do/catch, unless you use try? or try!, which isnt safe or requires optionals
 Function or property that 'tries' can 'catch' errors that are 'thrown' and handle them
 */

enum EncryptionError: Error {
    case empty
    case weak
}

struct Encryptor {
    func encrypt(_ message: String, password: String) throws -> String {
        guard !password.isEmpty else { throw EncryptionError.empty }
        guard password.count > 5 else { throw EncryptionError.weak }
        
        let encrypted = password + message + password
        return String(encrypted.reversed())
    }
}

struct DTCModule: View {
    let encryptor = Encryptor()
    let message = "Hello, World!"
    
    var encryptedMessage: String {
        do {
            return try encryptor.encrypt(message, password: "123")
        } catch let error as EncryptionError {
            return "Encryption error: \(error)"
        } catch {
            return "An unknown error ocurred"
        }
    }
    
    var body: some View {
        VStack {
            Text("Message: \(message)")
            Text("Encrypted: \(encryptedMessage)")
        }
    }
}

#Preview {
    DTCModule()
}
