//
//  TableViewItemDataSource.swift
//  LogicTest
//
//  Created by Hong Vu Xuan on 11/05/2022.
//

import UIKit

public protocol TableViewItemDataSource: AnyObject {
    var numberOfSections: Int { get }
    var numberOfRows: Int { get }
    func itemCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func didSelect(tableView: UITableView, indexPath: IndexPath)
}
