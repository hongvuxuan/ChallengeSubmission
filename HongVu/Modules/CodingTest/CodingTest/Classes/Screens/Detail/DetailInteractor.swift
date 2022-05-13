//
//  DetailInteractor.swift
//  CodingTest
//
//  Created by Hong Vu Xuan on 13/05/2022.
//

import VIPER

protocol DetailInteratorOutputs: AnyObject {
    
}

final class DetailInteractor: InteracterProtocol {
    
    weak var presenter: DetailInteratorOutputs?
}
