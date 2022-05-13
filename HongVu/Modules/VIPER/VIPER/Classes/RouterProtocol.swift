//
//  RouterProtocol.swift
//  LogicTest
//
//  Created by Hong Vu Xuan on 10/05/2022.
//

import UIKit

public protocol RouterProtocol {
    var view: ViewProtocol! { get }
    
    func pop(animated: Bool)
}

public extension RouterProtocol {
    
    func pop(animated: Bool) {
        view.pop(animated: animated)
    }
}
