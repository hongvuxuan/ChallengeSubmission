//
//  MainInteractor.swift
//  LogicTest
//
//  Created by Hong Vu Xuan on 10/05/2022.
//

import VIPER

protocol MainInteractorOutputs: AnyObject {
    func onSuccessFetchAllLogicTest(res: [TestEntity])
}

class MainInteractor: InteracterProtocol {
    
    weak var presenter: MainInteractorOutputs?
    
    func fetchAllLogicTest() {
        let test1 = TestEntity(type: .test1)
        let test2 = TestEntity(type: .test2)
        presenter?.onSuccessFetchAllLogicTest(res: [test1, test2])
    }
}
