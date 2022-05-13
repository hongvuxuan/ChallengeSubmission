//
//  HomeRouter.swift
//  LogicTest
//
//  Created by Hong Vu Xuan on 12/05/2022.
//

import VIPER
import LogicTest

public struct HomeRouterInput {
    
    private func view(entryEntity: TestEntity) -> HomeViewController {
        let bundle = Bundle(for: HomeViewController.self)
        let view = HomeViewController(nibName: "HomeViewController", bundle: bundle)
        let interactor = HomeInteractor()
        let dependencies = HomePresenterDependencies(interactor: interactor, router: HomeRouterOutput(view: view))
        let presenter = HomePresenter(entities: HomeEntities(entryEntity: entryEntity), view: view, dependencies: dependencies)
        view.presenter = presenter
        view.tableViewDataSource = HomeTableViewDataSource(entities: presenter.entities, presenter: presenter)
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

class HomeRouterOutput: RouterProtocol {
    
    private(set) weak public var view: ViewProtocol!
    
    init(view: ViewProtocol) {
        self.view = view
    }
    
    func navigateToDetail(_ ariticle: ArticleRepository) {
        DetailRouterInput().push(from: view, entryEntity: DetailEntryEntity(articleRepository: ariticle))
    }
}
