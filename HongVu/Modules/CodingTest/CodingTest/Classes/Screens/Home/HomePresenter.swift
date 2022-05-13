//
//  HomePresenter.swift
//  CodingTest
//
//  Created by Hong Vu Xuan on 12/05/2022.
//

import VIPER
import LogicTest

typealias HomePresenterDependencies = (
    interactor: HomeInteractor,
    router: HomeRouterOutput
)

final class HomePresenter: PresenterProtocol {
    
    var entities: HomeEntities
    private weak var view: HomeViewInputs!
    let dependencies: HomePresenterDependencies
    
    init(entities: HomeEntities, view: HomeViewInputs, dependencies: HomePresenterDependencies) {
        self.entities = entities
        self.view = view
        self.dependencies = dependencies
    }
}

extension HomePresenter: HomeViewOutputs {
    
    func viewDidLoad() {
        view.configure(entities: entities)
        entities.articlesAPIState.isFetching = true
        dependencies.interactor.fetchArticles(keyword: "apple", page: entities.articlesAPIState.pageCount)
    }
    
    func onItemSelected(at indexPath: IndexPath) {
        
    }
    
    func onReachBottom() {
        if entities.articlesAPIState.isFetching == true {
            return
        }
        entities.articlesAPIState.isFetching = true
        dependencies.interactor.fetchArticles(keyword: "apple", page: entities.articlesAPIState.pageCount)
        view.indicatorView(animate: true)
    }
}

extension HomePresenter: HomeInteractorOutputs {
    
    func fetchArticlesOnSuccess(_ response: ArticlesRepositoriesResponse) {
        entities.articlesAPIState.isFetching = false
        entities.articlesAPIState.pageCount += 1
        entities.articlesRepositories.append(contentsOf: response.articles ?? [])
        view.reloadTableView(tableViewDataSource: HomeTableViewDataSource(entities: entities, presenter: self))
        view.indicatorView(animate: false)
    }
    
    func fetchArticlesOnError(_ error: Error) {
        view.indicatorView(animate: false)
    }
}

extension HomePresenter: HomeTableViewDataSourceOutputs {
    
    func didSelect(_ article: ArticleRepository) {
        dependencies.router.navigateToDetail(article)
    }
}
