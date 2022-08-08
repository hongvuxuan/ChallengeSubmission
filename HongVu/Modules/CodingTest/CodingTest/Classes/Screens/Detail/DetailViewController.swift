//
//  DetailViewController.swift
//  CodingTest
//
//  Created by Hong Vu Xuan on 13/05/2022.
//

import UIKit
import VIPER

protocol DetailViewInputs: AnyObject {
    func configure(entities: DetailEntities)
}

protocol DetailViewOutputs: AnyObject {
    func viewDidLoad()
}

class DetailViewController: UIViewController {
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsPublishedAtLabel: UILabel!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    @IBOutlet weak var newsContentLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    internal var presenter: DetailViewOutputs?
    private var article: ArticleRepository?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
    }
}

extension DetailViewController: ViewProtocol {}

extension DetailViewController: DetailViewInputs {
    
    func configure(entities: DetailEntities) {
        newsImageView.downloadImageWithCaching(with: entities.entryEntity.articleRepository.urlToImage ?? "", placeholderImage: nil) { [weak self] in
            UIView.animate(withDuration: 1.0) {
                self?.newsImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }
        }
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(openSourceUrl))
        sourceLabel.isUserInteractionEnabled = true
        sourceLabel.addGestureRecognizer(tapGesture)
        let articleRepository = entities.entryEntity.articleRepository
        sourceLabel.attributedText = NSAttributedString(string: articleRepository.source?.name ?? "", attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 16.0), .underlineStyle: NSUnderlineStyle.single.rawValue])
        newsTitleLabel.text = articleRepository.title
        newsPublishedAtLabel.text = articleRepository.getPublishedAtString()
        newsDescriptionLabel.text = articleRepository.description
        newsContentLabel.text = articleRepository.content
        self.article = articleRepository
    }
    
    @objc func openSourceUrl() {
        guard let url = URL(string: article?.url ?? "") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
