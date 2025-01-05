//
//  CounterSampleApp.swift
//  CounterSample
//
//  Created by yuta on 2025/01/03.
//

import ComposableArchitecture
import SwiftUI

@main
struct CounterSampleApp: App {
    var body: some Scene {
        WindowGroup {
            CounterView(
                store: Store(initialState: CounterFeature.State()) {
                    CounterFeature()
                        ._printChanges()
                }
            )
        }
    }
}
