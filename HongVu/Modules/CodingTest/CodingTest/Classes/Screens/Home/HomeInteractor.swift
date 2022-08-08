//
//  HomeInteractor.swift
//  CodingTest
//
//  Created by Hong Vu Xuan on 12/05/2022.
//

import VIPER
import LogicTest

protocol HomeInteractorOutputs: AnyObject {
    func fetchCategoryOnSuccess(_ categories: [NewsAPI.CategoriesSupported])
    func fetchArticlesOnSuccess(_ response: ArticlesRepositoriesResponse)
    func fetchArticlesOnError(_ error: Error)
}

class HomeInteractor: InteracterProtocol {
    
    weak var presenter: HomeInteractorOutputs?
    
    func fetchCategories() {
        let categories = NewsAPI.CategoriesSupported.allCases
        presenter?.fetchCategoryOnSuccess(categories)
    }
    
    func fetchArticles(_ endpoint: NewsAPI.ArticlesRequest.EndPointType) {
        let request = NewsAPI.ArticlesRequest(endpointType: endpoint)
        NewsAPI().search(with: request, onSuccess: { [weak self] response in
            self?.presenter?.fetchArticlesOnSuccess(response)
        }, onError: { [weak self] error in
            self?.presenter?.fetchArticlesOnError(error)
        })
    }
}
