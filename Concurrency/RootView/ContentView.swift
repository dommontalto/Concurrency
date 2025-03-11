//
//  ContentView.swift
//  Concurrency
//
//  Created by Dominic Montalto on 25/02/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var show = false

    var body: some View {
        NavigationStack {
            VStack {
                Button("Click Me") {
                    show.toggle()
                }
            }
            .navigationDestination(isPresented: $show) {
                TasksModule()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
