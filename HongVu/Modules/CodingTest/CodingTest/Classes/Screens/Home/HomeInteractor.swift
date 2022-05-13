//
//  HomeInteractor.swift
//  CodingTest
//
//  Created by Hong Vu Xuan on 12/05/2022.
//

import VIPER
import LogicTest

protocol HomeInteractorOutputs: AnyObject {
    func fetchArticlesOnSuccess(_ response: ArticlesRepositoriesResponse)
    func fetchArticlesOnError(_ error: Error)
}

class HomeInteractor: InteracterProtocol {
    
    weak var presenter: HomeInteractorOutputs?
    
    func fetchArticles(keyword: String, page: Int) {
        let request = NewsAPI.ArticlesRequest(q: keyword, from: "2022-05-11", to: "2022-05-12", pageSize: 10, page: page)
        NewsAPI().search(with: request, onSuccess: { [weak self] response in
            self?.presenter?.fetchArticlesOnSuccess(response)
        }, onError: { [weak self] error in
            self?.presenter?.fetchArticlesOnError(error)
        })
    }
}
