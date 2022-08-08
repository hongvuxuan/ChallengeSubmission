//
//  DateExtension.swift
//  CodingTest
//
//  Created by Hong Vu Xuan on 08/08/2022.
//

import Foundation

public extension Date {
    func string(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
