//
//  MainTableViewDataSource.swift
//  LogicTest
//
//  Created by Hong Vu Xuan on 11/05/2022.
//

import UIKit
import VIPER

protocol MainTableViewDataSourceOutputs: AnyObject {
    func didSelect(_ testEntity: TestEntity)
}

class MainTableViewDataSource {
    private weak var entities: MainEntities!
    private weak var presenter: MainTableViewDataSourceOutputs?

    init(entities: MainEntities, presenter: MainTableViewDataSourceOutputs) {
        self.entities = entities
        self.presenter = presenter
    }
}

extension MainTableViewDataSource: TableViewItemDataSource {
    
    var numberOfSections: Int {
        if entities.testRepositories.count > 0 {
            return 1
        } else {
            return 0
        }
    }
    
    var numberOfRows: Int {
        return entities.testRepositories.count
    }
    
    func itemCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let entity = entities.testRepositories[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "UITableViewCell")
        cell.textLabel?.text = "\(entity.type.title)"
        cell.detailTextLabel?.textColor = UIColor.lightGray
        cell.detailTextLabel?.text = "\(entity.type.description)"
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }
    
    func didSelect(tableView: UITableView, indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let entity = entities.testRepositories[indexPath.row]
        presenter?.didSelect(entity)
    }
}
