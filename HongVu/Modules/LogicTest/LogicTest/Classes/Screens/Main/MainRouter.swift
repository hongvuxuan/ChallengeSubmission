//
//  MainRouter.swift
//  LogicTest
//
//  Created by Hong Vu Xuan on 10/05/2022.
//

import VIPER

public struct MainRouterInput {
    
    private func view(entryEntity: TestEntity) -> MainViewController {
        let bundle = Bundle(for: MainViewController.self)
        let view = MainViewController(nibName: "MainViewController", bundle: bundle)
        let interactor = MainInteractor()
        let dependencies = MainPresenterDependencies(interactor: interactor, router: MainRouterOutput(view))
        let presenter = MainPresenter(entities: MainEntities(entity: entryEntity), view: view, dependencies: dependencies)
        view.presenter = presenter
        view.tableViewDataSource = MainTableViewDataSource(entities: presenter.entities, presenter: presenter)
        interactor.presenter = presenter
        return view
    }

    public func push(from: ViewProtocol, entryEntity: TestEntity) {
        let view = self.view(entryEntity: entryEntity)
        from.push(view, animated: true)
    }
    
    public func present(from: ViewProtocol, entryEntity: TestEntity) {
        let nav = UINavigationController(rootViewController: view(entryEntity: entryEntity))
        from.present(nav, animated: true)
    }
    
    public init() { }
}

public class MainRouterOutput: RouterProtocol {

    private(set) weak public var view: ViewProtocol!
    
    init(_ view: ViewProtocol) {
        self.view = view
    }
    
    func navigateTo(entity: TestEntity) {
        Test1RouterInput().push(from: view, entryEntity: entity)
    }
}
