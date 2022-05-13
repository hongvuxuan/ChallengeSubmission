//
//  Test1Router.swift
//  LogicTest
//
//  Created by Hong Vu Xuan on 11/05/2022.
//

import VIPER

public struct Test1RouterInput {
    
    private func view(entryEntity: TestEntity) -> Test1ViewController {
        let bundle = Bundle(for: Test1ViewController.self)
        let view = Test1ViewController(nibName: "Test1ViewController", bundle: bundle)
        let interactor = Test1Interactor()
        let dependencies = Test1PresenterDependencies(interactor: interactor, router: Test1Router(view))
        let presenter = Test1Presenter(entities: Test1Entities(entity: entryEntity), view: view, dependencies: dependencies)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }

    public func push(from: ViewProtocol, entryEntity: TestEntity) {
        let view = self.view(entryEntity: entryEntity)
        from.push(view, animated: true)
    }
    
    private func popupView(with message: String) -> UIAlertController {
        let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertVC.addAction(okAction)
        return alertVC
    }
    
    public func presentPopup(message: String, from: ViewProtocol) {
        let view = popupView(with: message)
        from.present(view, animated: true)
    }
    
    public init() { }
}

public class Test1Router: RouterProtocol {
    
    private(set) weak public var view: ViewProtocol!
    
    init(_ view: ViewProtocol) {
        self.view = view
    }
    
    func showPopup(message: String) {
        Test1RouterInput().presentPopup(message: message, from: view)
    }
}
