//
//  ContentView.swift
//  CounterSample
//
//  Created by yuta on 2025/01/03.
//

import SwiftUI

@Observable
final class ContentViewModel {
    private(set) var count = 0

    func incrementButtonTapped() {
        count += 1
    }

    func decrementButtonTapped() {
        count -= 1
    }
}

struct ContentView: View {
    @State private var viewModel = ContentViewModel()

    var body: some View {
        VStack {
            Text("\(viewModel.count)")

            HStack {
                Button("Increment") {
                    viewModel.incrementButtonTapped()
                }

                Button("Decrement") {
                    viewModel.decrementButtonTapped()
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
