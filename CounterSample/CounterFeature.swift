//
//  CounterFeature.swift
//  CounterSample
//
//  Created by yuta on 2025/01/05.
//

import ComposableArchitecture
import Foundation
import SwiftUI

@Reducer
struct CounterFeature {
    @ObservableState
    struct State: Equatable {
        var count = 0
        var fact: String?
        var isLoading = false
    }

    enum Action {
        case decrementButtonTapped
        case factButtonTapped
        case factResponse(String)
        case incrementButtonTapped
    }

    @Dependency(\.numberFact) var numberFact

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .decrementButtonTapped:
                state.count -= 1
                state.fact = nil
                return .none

            case .factButtonTapped:
                state.fact = nil
                state.isLoading = true
                return .run { [count = state.count] send in
                    try await send(.factResponse(numberFact.fetch(count)))
                }

            case let .factResponse(fact):
                state.fact = fact
                state.isLoading = false
                return .none

            case .incrementButtonTapped:
                state.count += 1
                state.fact = nil
                return .none
            }
        }
    }
}

struct CounterView: View {
    let store: StoreOf<CounterFeature>

    var body: some View {
        VStack {
            Text("\(store.count)")
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
            HStack {
                Button("-") {
                    store.send(.decrementButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)

                Button("+") {
                    store.send(.incrementButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
            }
            Button("Fact") {
                store.send(.factButtonTapped)
            }
            .font(.largeTitle)
            .padding()
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)
            if store.isLoading {
                ProgressView()
            } else if let fact = store.fact {
                Text(fact)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
    }
}

#Preview {
    CounterView(
        store: Store(initialState: CounterFeature.State()) {
            CounterFeature()
        }
    )
}
