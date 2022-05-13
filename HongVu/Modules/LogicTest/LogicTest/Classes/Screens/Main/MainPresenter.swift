//
//  MainPresenter.swift
//  LogicTest
//
//  Created by Hong Vu Xuan on 10/05/2022.
//

import Foundation
import VIPER

typealias MainPresenterDependencies = (
    interactor: MainInteractor,
    router: MainRouterOutput
)

final class MainPresenter: PresenterProtocol {
    
    var entities: MainEntities
    private weak var view: MainViewInputs!
    let dependencies: MainPresenterDependencies
    
    init(entities: MainEntities, view: MainViewInputs, dependencies: MainPresenterDependencies) {
        self.entities = entities
        self.view = view
        self.dependencies = dependencies
    }
}

extension MainPresenter: MainViewOutputs {
    
    func viewDidLoad() {
        view.configure(entities: entities)
        dependencies.interactor.fetchAllLogicTest()
    }
    
    func onItemSelected(at indexPath: IndexPath) {
        
    }
}

extension MainPresenter: MainInteractorOutputs {
    
    func onSuccessFetchAllLogicTest(res: [TestEntity]) {
        entities.testRepositories = res
        view.reloadTableView(tableViewDataSource: MainTableViewDataSource(entities: entities, presenter: self))
    }
}

extension MainPresenter: MainTableViewDataSourceOutputs {
    
    func didSelect(_ testEntity: TestEntity) {
        dependencies.router.navigateTo(entity: testEntity)
    }
}
