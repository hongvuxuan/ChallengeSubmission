//
//  DetailPresenter.swift
//  CodingTest
//
//  Created by Hong Vu Xuan on 13/05/2022.
//

import VIPER
import WebKit

typealias DetailPresenterDependencies = (
    interactor: DetailInteractor,
    router: DetailRouterOutput
)

class DetailPresenter: PresenterProtocol {
    
    internal var entities: DetailEntities
    private weak var view: DetailViewInputs!
    let dependencies: DetailPresenterDependencies
    
    init(entities: DetailEntities,
         view: DetailViewInputs,
         dependencies: DetailPresenterDependencies) {
        self.entities = entities
        self.view = view
        self.dependencies = dependencies
    }
}

extension DetailPresenter: DetailViewOutputs {
    func viewDidLoad() {
        view.configure(entities: entities)
    }
}

extension DetailPresenter: DetailInteratorOutputs {
    
}
