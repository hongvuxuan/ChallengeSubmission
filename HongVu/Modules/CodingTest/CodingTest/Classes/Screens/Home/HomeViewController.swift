//
//  HomeViewController.swift
//  LogicTest
//
//  Created by Hong Vu Xuan on 12/05/2022.
//

import UIKit
import VIPER

protocol HomeViewInputs: AnyObject {
    func configure(entities: HomeEntities)
    func reloadTableView(tableViewDataSource: HomeTableViewDataSource)
    func indicatorView(animate: Bool)
}

protocol HomeViewOutputs: AnyObject {
    func viewDidLoad()
    func onReachBottom()
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var indicatorView: UIActivityIndicatorView?

    var presenter: HomeViewOutputs?
    var tableViewDataSource: TableViewItemDataSource?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bundle = Bundle(for: HomeTableViewCell.self)
        tableView?.register(UINib(nibName: "HomeTableViewCell", bundle: bundle), forCellReuseIdentifier: "HomeTableViewCell")
        presenter?.viewDidLoad()
    }
}

extension HomeViewController: HomeViewInputs {
    
    func configure(entities: HomeEntities) {
        navigationItem.title = entities.title
    }
    
    func reloadTableView(tableViewDataSource: HomeTableViewDataSource) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView?.reloadData()
        }
    }
    
    func indicatorView(animate: Bool) {
        DispatchQueue.main.async { [weak self] in
            let bottom: CGFloat
            if animate {
                self?.indicatorView?.startAnimating()
                bottom = 50
            } else {
                self?.indicatorView?.stopAnimating()
                bottom = 0
            }
            self?.tableView?.contentInset = UIEdgeInsets(top: 0,
                                                        left: 0,
                                                        bottom: bottom,
                                                        right: 0)
            
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleLastIndexPath = tableView?.visibleCells.compactMap { [weak self] in
            self?.tableView?.indexPath(for: $0)
        }.last
        guard let last = visibleLastIndexPath, last.row > (tableViewDataSource?.numberOfRows ?? 0) - 2 else {
            return
        }
        presenter?.onReachBottom()
    }
}

extension HomeViewController: ViewProtocol {}
