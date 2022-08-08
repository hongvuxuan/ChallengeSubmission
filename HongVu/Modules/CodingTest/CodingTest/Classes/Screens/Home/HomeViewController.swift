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
    func reloadCategories(_ categories: [HomeEntities.Category])
    func reloadTableView(tableViewDataSource: HomeTableViewDataSource)
    func indicatorView(animate: Bool)
}

protocol HomeViewOutputs: AnyObject {
    func viewDidLoad()
    func openCategory()
    func selectCategory(_ category: NewsAPI.CategoriesSupported)
    func onReachBottom()
    func search(text: String?)
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var indicatorView: UIActivityIndicatorView?
    @IBOutlet weak var searchBar: UISearchBar?

    var presenter: HomeViewOutputs?
    var tableViewDataSource: TableViewItemDataSource?
    
    private var searchText: String?
    private var autoSearchMng: AutoSearchManager?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let categoryButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(categoryAction(_:)))
        self.navigationItem.rightBarButtonItem = categoryButton
        
        let bundle = Bundle(for: HomeTableViewCell.self)
        tableView?.register(UINib(nibName: "HomeTableViewCell", bundle: bundle), forCellReuseIdentifier: "HomeTableViewCell")
        presenter?.viewDidLoad()
        
        searchBar?.returnKeyType = .done
        autoSearchMng = AutoSearchManager(callback: { [weak self] _ in
            self?.autoSearchAction()
        })
    }
    
    @objc private func categoryAction(_ sender: UIBarButtonItem) {
        presenter?.openCategory()
    }
    
    func autoSearchAction() {
        presenter?.search(text: searchText)
    }
}

extension HomeViewController: HomeViewInputs {
    
    func configure(entities: HomeEntities) {
        navigationItem.title = entities.title
    }
    
    func reloadCategories(_ categories: [HomeEntities.Category]) {
        let categoryVC = CategoryViewController(withItems: categories)
        categoryVC.delegate = self
        categoryVC.modalPresentationStyle = .popover
        categoryVC.popoverPresentationController?.permittedArrowDirections = .up
        categoryVC.popoverPresentationController?.sourceView = self.view
        categoryVC.popoverPresentationController?.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.minY, width: 0, height: 0)
        categoryVC.popoverPresentationController?.delegate = self
        let navController = UINavigationController(rootViewController: categoryVC)
        present(navController, animated: true, completion: nil)
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

extension HomeViewController: CategoryViewControllerDelegate {
    
    func category(_ vc: CategoryViewController, didSelect item: HomeEntities.Category) {
        presenter?.selectCategory(item.type)
        vc.dismiss(animated: true)
    }
}

extension HomeViewController: UIPopoverPresentationControllerDelegate {
    
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        autoSearchMng?.activate()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        self.searchText = nil
        autoSearchMng?.cancel()
    }
}

extension HomeViewController: ViewProtocol {}
