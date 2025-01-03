//
//  ContentViewModelTests.swift
//  CounterSampleTests
//
//  Created by yuta on 2025/01/03.
//

import Testing

@testable import CounterSample

struct ContentViewModelTests {
    @Test
    func カウントの初期値は0() async throws {
        let viewModel = ContentViewModel()
        #expect(viewModel.count == 0)
    }

    @Test
    func インクリメントボタンを押すとカウントが1になる() async throws {
        let viewModel = ContentViewModel()
        viewModel.incrementButtonTapped()
        #expect(viewModel.count == 1)
    }

    @Test
    func デクリメントボタンを押すとカウントがマイナス1になる() async throws {
        let viewModel = ContentViewModel()
        viewModel.decrementButtonTapped()
        #expect(viewModel.count == -1)
    }
}
