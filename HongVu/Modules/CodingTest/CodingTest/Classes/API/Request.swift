//
//  Request.swift
//  CodingTest
//
//  Created by Hong Vu Xuan on 12/05/2022.
//

import Foundation

public protocol Request {
    var url: String { get }
    var apiKey: String { get }
    func params() -> [(key: String, value: String)]
}
