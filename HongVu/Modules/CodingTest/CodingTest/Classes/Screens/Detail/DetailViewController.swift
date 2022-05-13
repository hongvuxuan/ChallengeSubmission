//
//  DetailViewController.swift
//  CodingTest
//
//  Created by Hong Vu Xuan on 12/05/2022.
//

import UIKit
import WebKit
import VIPER

protocol DetailViewInputs: AnyObject {
    func configure(entities: DetailEntities)
    func requestWebView(with request: URLRequest)
    func indicatorView(animate: Bool)
}

protocol DetailViewOutputs: AnyObject {
    func viewDidLoad()
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
}

class DetailViewController: UIViewController {
    
    @IBOutlet private weak var indicatorView: UIActivityIndicatorView?
    @IBOutlet private weak var webView: WKWebView?
    
    internal var presenter: DetailViewOutputs?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView?.navigationDelegate = self
        
        presenter?.viewDidLoad()
    }
}

extension DetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        presenter?.webView(webView, didFinish: navigation)
    }
}

extension DetailViewController: DetailViewInputs {
    
    func configure(entities: DetailEntities) {
        title = entities.title
    }
    
    func requestWebView(with request: URLRequest) {
        webView?.load(request)
    }

    func indicatorView(animate: Bool) {
        DispatchQueue.main.async { [weak self] in
            if animate {
                self?.indicatorView?.startAnimating()
            } else {
                self?.indicatorView?.stopAnimating()
            }
        }
    }
}

extension DetailViewController: ViewProtocol {}
