//
//  MainViewController.swift
//  LogicTest
//
//  Created by Hong Vu Xuan on 10/05/2022.
//

import UIKit
import VIPER

protocol MainViewInputs: AnyObject {
    func configure(entities: MainEntities)
    func reloadTableView(tableViewDataSource: TableViewItemDataSource)
}

protocol MainViewOutputs {
    func viewDidLoad()
    func onItemSelected(at indexPath: IndexPath)
}

class MainViewController: UIViewController {
    
    var presenter: MainViewOutputs?
    var tableViewDataSource: TableViewItemDataSource?
    
    @IBOutlet weak var tableView: UITableView?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension MainViewController: ViewProtocol {}

extension MainViewController: MainViewInputs {
    
    func configure(entities: MainEntities) {
        navigationItem.title = entities.entity.type.title
    }
    
    func reloadTableView(tableViewDataSource: TableViewItemDataSource) {
        self.tableViewDataSource = tableViewDataSource
        DispatchQueue.main.async { [weak self] in
            self?.tableView?.reloadData()
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewDataSource?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataSource?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewDataSource?.itemCell(tableView: tableView, indexPath: indexPath) ?? UITableViewCell()
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableViewDataSource?.didSelect(tableView: tableView, indexPath: indexPath)
    }
}

