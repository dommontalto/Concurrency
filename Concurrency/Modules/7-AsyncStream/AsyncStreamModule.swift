//
//  AsyncStreamModule.swift
//  Concurrency
//
//  Created by Dominic Montalto on 19/03/2025.
//

import SwiftUI

class AsyncStreamDataProvider {
    let prices = [67123, 68000, 68521, 66521, 67472]
    
   // suports errors: func getAsyncThrowingStream() -> AsyncStream<Int, Error> {

    func getAsyncStream() -> AsyncStream<Int> {
        AsyncStream { continuation in
            
            continuation.onTermination = { _ in
                print("Handle tear down")
            }
            
            for i in 0 ..< prices.count {
                let price = prices[i]
                
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                    continuation.yield(price)
                    
                    if i == self.prices.count - 1 {
                        continuation.finish()
                    }
                }
            }
            
    // HOW TO CONVERT IF FIREBASE USES COMPLETION HANDLERS

            
//            self.getData { price in
//                continuation.yield(price)
//            }
        }
    }
    
    // HOW TO CONVERT IF FIREBASE USES COMPLETION HANDLERS
    
//    func getData(completion: @escaping(Int) -> Void) {
//
//        for i in 0 ..< prices.count {
//            let price = prices[i]
//            
//            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
//                completion(price)
//            }
//        }
//    }
}

@MainActor
class AsyncStreamViewModel: ObservableObject {
    @Published var currentPrice: Int = 0
    
    private let dataProvider = AsyncStreamDataProvider()
    
    // HOW TO CONVERT IF FIREBASE USES COMPLETION HANDLERS
    
//    init() {
//        getDataWithCompletionHandler()
//    }
    
    func getData() async {
        print("Started stream")
        
        for await price in dataProvider.getAsyncStream() {
            print("Streamed price \(price)")
            self.currentPrice = price
        }
        
        print("Ended stream")
    }
    
    // HOW TO CONVERT IF FIREBASE USES COMPLETION HANDLERS
    
//    func getDataWithCompletionHandler() {
//        dataProvider.getData { [weak self] price in
//            self?.currentPrice = price
//        }
//    }
}

struct AsyncStreamModule: View {
    @StateObject var viewModel = AsyncStreamViewModel()
    
    var body: some View {
        HStack {
            Text("BTC")
            
            Spacer()
            
            Text("$\(viewModel.currentPrice)")
        }
        .task {
            await viewModel.getData()
        }
        .padding()
    }
}

#Preview {
    AsyncStreamModule()
}
