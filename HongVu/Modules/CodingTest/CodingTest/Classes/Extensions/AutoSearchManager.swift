//
//  AutoSearchManager.swift
//  CodingTest
//
//  Created by Hong Vu Xuan on 08/08/2022.
//

import Foundation

public class AutoSearchManager {

    // MARK: - Properties

    private let shortInterval: TimeInterval
    private let longInterval: TimeInterval
    private let callback: (Any?) -> Void

    private var shortTimer: Timer?
    private var longTimer: Timer?

    // MARK: - Lifecycle

    public init(
        short: TimeInterval = Constants.shortAutoSearchDelay,
        long: TimeInterval = Constants.longAutoSearchDelay,
        callback: @escaping (Any?) -> Void
    ) {
        shortInterval = short
        longInterval = long
        self.callback = callback
    }

    // MARK: - Methods

    public func activate(_ object: Any? = nil) {
        shortTimer?.invalidate()
        shortTimer = Timer.scheduledTimer(
            withTimeInterval: shortInterval,
            repeats: false
        ) { [weak self] _ in self?.fire(object) }

        if longTimer == nil {
            longTimer = Timer.scheduledTimer(
                withTimeInterval: longInterval,
                repeats: false
            ) { [weak self] _ in self?.fire(object) }
        }
    }

    public func cancel() {
        shortTimer?.invalidate()
        longTimer?.invalidate()
        shortTimer = nil
        longTimer = nil
    }

    // MARK: - Private methods

    private func fire(_ object: Any? = nil) {
        cancel()
        callback(object)
    }
}

// MARK: - Constants

extension AutoSearchManager {
    
    public enum Constants {

        public static let longAutoSearchDelay: TimeInterval = 2.0
        public static let shortAutoSearchDelay: TimeInterval = 0.75
    }
}
