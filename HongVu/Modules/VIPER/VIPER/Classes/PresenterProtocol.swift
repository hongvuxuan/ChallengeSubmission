//
//  PresenterProtocol.swift
//  LogicTest
//
//  Created by Hong Vu Xuan on 10/05/2022.
//

import Foundation

public protocol PresenterProtocol {
    associatedtype I: InteracterProtocol
    associatedtype R: RouterProtocol
    var dependencies: (interactor: I, router: R) { get }
}
