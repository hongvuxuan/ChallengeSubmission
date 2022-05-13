//
//  Test1ViewController.swift
//  LogicTest
//
//  Created by Hong Vu Xuan on 11/05/2022.
//

import UIKit
import VIPER

enum Test1Result {
    case success(message: String)
    case failure(message: String)
}

protocol Test1ViewInputs: AnyObject {
    func configure(entities: Test1Entities)
    func showResult(_ result: Test1Result)
}

protocol Test1ViewOutputs: AnyObject {
    func viewDidLoad()
    func onButtonClicked(with string: String)
}

class Test1ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView?
    @IBOutlet weak var textFieldTitle: UILabel?
    @IBOutlet weak var textField: UITextField?
    @IBOutlet weak var button: UIButton?
    @IBOutlet weak var resultLabel: UILabel?
    
    var presenter: Test1ViewOutputs?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView?.isEditable = false
        textField?.keyboardType = .numbersAndPunctuation
        
        presenter?.viewDidLoad()
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        textField?.resignFirstResponder()
        let text: String = textField?.text ?? ""
        presenter?.onButtonClicked(with: text)
    }
}

extension Test1ViewController: ViewProtocol {}

extension Test1ViewController: Test1ViewInputs {
    
    func configure(entities: Test1Entities) {
        navigationItem.title = entities.entity.type.title
        textView?.text = entities.entity.type.details
        
        switch entities.entity.type {
        case .test1:
            button?.setTitle("Find Middle Index", for: .normal)
            textFieldTitle?.text = "Enter your array of the numbers. Ex: 1,3,5,7,9"
        case .test2:
            button?.setTitle("Check Palindrome", for: .normal)
            textFieldTitle?.text = "Enter your string"
        }
    }
    
    func showResult(_ result: Test1Result) {
        switch result {
        case .success(let message):
            resultLabel?.text = message
        case .failure(let message):
            resultLabel?.text = message
        }
        
    }
}

extension Test1ViewController: UITextViewDelegate {
    
}
