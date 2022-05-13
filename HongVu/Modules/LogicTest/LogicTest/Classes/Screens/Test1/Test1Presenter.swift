//
//  Test1Presenter.swift
//  LogicTest
//
//  Created by Hong Vu Xuan on 11/05/2022.
//

import VIPER

typealias Test1PresenterDependencies = (
    interactor: Test1Interactor,
    router: Test1Router
)

final class Test1Presenter: PresenterProtocol {
    
    var entities: Test1Entities
    private weak var view: Test1ViewInputs!
    let dependencies: Test1PresenterDependencies
    
    init(entities: Test1Entities, view: Test1ViewInputs, dependencies: Test1PresenterDependencies) {
        self.entities = entities
        self.view = view
        self.dependencies = dependencies
    }
}

extension Test1Presenter: Test1ViewOutputs {
    
    func viewDidLoad() {
        view.configure(entities: entities)
    }
    
    func onButtonClicked(with string: String) {
        switch entities.entity.type {
        case .test1:
            let arrayString = string.components(separatedBy: ",")
            var arrayInt: [Int] = []
            var isError: Bool = false
            for s in arrayString {
                if let i = Int(s) {
                    arrayInt.append(i)
                } else {
                    isError = true
                    break
                }
            }
            
            if isError {
                dependencies.router.showPopup(message: "Your array of the numbers is incorrect. Please try again.")
                view.showResult(Test1Result.failure(message: ""))
            } else {
                dependencies.interactor.findTheMiddleIndex(array: arrayInt)
            }
        case .test2:
            if string.isEmpty {
                dependencies.router.showPopup(message: "Your incoming string is empty. Please try again.")
            } else {
                dependencies.interactor.checkPalindrome(string)
            }
        }
    }
}

extension Test1Presenter: Test1InteractorOutputs {
    
    func onResultFindTheMiddleIndex(index: Int?, value: Int?) {
        if let _index = index, let _value = value {
            view.showResult(Test1Result.success(message: "Middle index is \(_index). Value is \(_value)."))
        } else {
            view.showResult(Test1Result.failure(message: "Middle index is not found!"))
        }
    }
    
    func onResultCheckPalindrome(string: String, isPalimdrome: Bool) {
        if isPalimdrome {
            view.showResult(Test1Result.success(message: "\(string) is a palindrome."))
        } else {
            view.showResult(Test1Result.success(message: "\(string) isn't a palindrome."))
        }
    }
}
