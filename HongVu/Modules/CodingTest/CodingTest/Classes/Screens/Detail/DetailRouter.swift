//
//  DetailRouter.swift
//  CodingTest
//
//  Created by Hong Vu Xuan on 13/05/2022.
//

import UIKit
import VIPER

struct DetailRouterInput {
    
    private func view(entryEntity: DetailEntryEntity) -> DetailViewController {
        let bundle = Bundle(for: HomeViewController.self)
        let view = DetailViewController(nibName: "DetailViewController", bundle: bundle)
        let interactor = DetailInteractor()
        let dependencies = DetailPresenterDependencies(interactor: interactor, router: DetailRouterOutput(view: view))
        let presenter = DetailPresenter(entities: DetailEntities(entryEntity: entryEntity), view: view, dependencies: dependencies)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
    
    func push(from: ViewProtocol, entryEntity: DetailEntryEntity) {
        let view = self.view(entryEntity: entryEntity)
        from.push(view, animated: true)
    }
}

class DetailRouterOutput: RouterProtocol {
    
    private(set) public weak var view: ViewProtocol!
    
    init(view: ViewProtocol) {
        self.view = view
    }
}
