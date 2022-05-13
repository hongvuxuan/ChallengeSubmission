//
//  HomeTableViewDataSource.swift
//  CodingTest
//
//  Created by Hong Vu Xuan on 12/05/2022.
//

import UIKit
import VIPER

protocol HomeTableViewDataSourceOutputs: AnyObject {
    func didSelect(_ article: ArticleRepository)
}

class HomeTableViewDataSource {
    private weak var entities: HomeEntities!
    private weak var presenter: HomeTableViewDataSourceOutputs?

    init(entities: HomeEntities, presenter: HomeTableViewDataSourceOutputs) {
        self.entities = entities
        self.presenter = presenter
    }
}

extension HomeTableViewDataSource: TableViewItemDataSource {
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfRows: Int {
        return entities.articlesRepositories.count
    }
    
    func itemCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        let article = entities.articlesRepositories[indexPath.row]
        cell.title?.text = article.title
        cell.shortDetailsLable?.text = article.description
        cell.thumnailImageView?.downloadImageWithCaching(with: article.urlToImage ?? "", placeholderImage: nil)
        return cell
    }
    
    func didSelect(tableView: UITableView, indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = entities.articlesRepositories[indexPath.row]
        presenter?.didSelect(article)
    }
}
