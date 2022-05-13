//
//  ViewProtocol.swift
//  LogicTest
//
//  Created by Hong Vu Xuan on 10/05/2022.
//

import UIKit

public protocol ViewProtocol: AnyObject {

    func push(_ vc: UIViewController, animated: Bool)
    
    func pop(animated: Bool)
    
    func present(_ vc: UIViewController, animated: Bool)
    
    func dismiss(animated: Bool)
    
    func dismiss(animated: Bool, _completion:  @escaping (() -> Void))
}

public extension ViewProtocol where Self: UIViewController {
    
    func push(_ vc: UIViewController, animated: Bool) {
        self.navigationController?.pushViewController(vc, animated: animated)
    }
    
    func pop(animated: Bool) {
        self.navigationController?.popViewController(animated: animated)
    }
    
    func present(_ vc: UIViewController, animated: Bool) {
        self.present(vc, animated: animated, completion: nil)
    }
    
    func dismiss(animated: Bool) {
        self.dismiss(animated: animated, completion: nil)
    }

    func dismiss(animated: Bool, _completion: @escaping (() -> Void)) {
        self.dismiss(animated: animated, completion: _completion)
    }
}
