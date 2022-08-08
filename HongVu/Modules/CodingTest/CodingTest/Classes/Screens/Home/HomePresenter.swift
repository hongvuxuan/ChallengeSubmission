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
        
        onReachBottom()
    }
    
    func openCategory() {
        dependencies.interactor.fetchCategories()
    }
    
    func selectCategory(_ category: NewsAPI.CategoriesSupported) {
        entities.category = category
        
        entities.articlesRepositories = []
        entities.articlesAPIState.pageCount = 1
        
        view.reloadTableView(tableViewDataSource: HomeTableViewDataSource(entities: entities, presenter: self))
        
        onReachBottom()
    }
    
    func search(text: String?) {
        print("Search with keyword: \(text ?? "")")
        if let mText = text, !mText.isEmpty {
            entities.articlesRepositories = []
            entities.articlesAPIState.pageCount = 1
            view.reloadTableView(tableViewDataSource: HomeTableViewDataSource(entities: entities, presenter: self))
            
            dependencies.interactor.fetchArticles(.everything(q: text, pageSize: 10, page: entities.articlesAPIState.pageCount))
        } else {
            selectCategory(entities.category)
        }
    }
    
    func onItemSelected(at indexPath: IndexPath) {
        
    }
    
    func onReachBottom() {
        if entities.articlesAPIState.isFetching == true {
            return
        }
        entities.articlesAPIState.isFetching = true
        dependencies.interactor.fetchArticles(.topHeadlines(category: entities.category.rawValue,
                                                            country: "us",
                                                            q: nil,
                                                            pageSize: 10,
                                                            page: entities.articlesAPIState.pageCount))
        view.indicatorView(animate: true)
    }
}

extension HomePresenter: HomeInteractorOutputs {
    
    func fetchCategoryOnSuccess(_ categories: [NewsAPI.CategoriesSupported]) {
        var categoryItems = [HomeEntities.Category]()
        for category in categories {
            let selected = category == entities.category
            let categoryItem = HomeEntities.Category(type: category, selected: selected)
            categoryItems.append(categoryItem)
        }
        view.reloadCategories(categoryItems)
    }
    
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
