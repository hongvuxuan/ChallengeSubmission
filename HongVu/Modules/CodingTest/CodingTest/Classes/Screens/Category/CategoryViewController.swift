//
//  CategoryViewController.swift
//  CodingTest
//
//  Created by Hong Vu Xuan on 08/08/2022.
//

import UIKit

protocol CategoryViewControllerDelegate: AnyObject {
    func category(_ vc: CategoryViewController, didSelect item: HomeEntities.Category)
}

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: CategoryViewControllerDelegate?
    private var items: [HomeEntities.Category] = []
    
    init(withItems: [HomeEntities.Category]) {
        self.items = withItems
        let bundle = Bundle(for: CategoryViewController.self)
        super.init(nibName: "CategoryViewController", bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Select Category"
        
        let closeButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closeAction(_:)))
        navigationItem.leftBarButtonItem = closeButton
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
    }
    
    @objc private func closeAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath) 
        let item = items[indexPath.row]
        cell.textLabel?.text = item.type.name
        if item.selected {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        delegate?.category(self, didSelect: item)
    }
}
