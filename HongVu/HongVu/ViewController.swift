//
//  ViewController.swift
//  HongVu
//
//  Created by Hong Vu Xuan on 11/05/2022.
//

import UIKit
import VIPER
import LogicTest
import CodingTest

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Hong Vu's iOS Test"
    }
}

extension ViewController: ViewProtocol {}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "UITableViewCell")
        var title: String = ""
        switch indexPath.row {
        case 0:
            title = "Logic Test"
        case 1:
            title = "Coding Test"
        default:
            break
        }
        cell.textLabel?.text = title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            MainRouterInput().present(from: self, entryEntity: TestEntity(type: .test1))
        case 1:
            HomeRouterInput().present(from: self, entryEntity: TestEntity(type: .test2))
        default:
            break
        }
    }
}

