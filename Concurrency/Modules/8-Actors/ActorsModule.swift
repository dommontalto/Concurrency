//
//  ActorsModule.swift
//  Concurrency
//
//  Created by Dominic Montalto on 19/03/2025.
//

import SwiftUI

actor BankAccount {
    private var balance: Double

    init(balance: Double) {
        self.balance = balance
    }

    func deposit(_ amount: Double) {
        balance += amount
    }

    func transfer(_ amount: Double, to otherAccount: BankAccount) async {
        guard balance >= amount else {
            print("Insufficient funds!")
            return
        }

        balance -= amount
        await otherAccount.deposit(amount)
    }

    func getBalance() -> Double {
        return balance
    }
}

struct ActorsModule: View {
    let account1 = BankAccount(balance: 100)
    let account2 = BankAccount(balance: 50)

    var body: some View {
        Button("Click Me") {
            Task {
                await account1.transfer(30, to: account2)
                print("Task 1 - Account1: \(await account1.getBalance()), Account2: \(await account2.getBalance())")
            }

            Task {
                await account1.transfer(50, to: account2)
                print("Task 2 - Account1: \(await account1.getBalance()), Account2: \(await account2.getBalance())")
            }
        }
    }
}

#Preview {
    ActorsModule()
}
