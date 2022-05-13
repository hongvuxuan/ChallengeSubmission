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
        if let url = URL(string: entities.entryEntity.articleRepository.url ?? "") {
            let urlRequest = URLRequest(url: url)
            view.requestWebView(with: urlRequest)
            view.indicatorView(animate: true)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        view.indicatorView(animate: false)
    }
}

extension DetailPresenter: DetailInteratorOutputs {
    
}
