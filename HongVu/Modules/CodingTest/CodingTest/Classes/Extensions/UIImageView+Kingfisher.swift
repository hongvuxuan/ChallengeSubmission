//
//  UIImageView+Kingfisher.swift
//  CodingTest
//
//  Created by Hong Vu Xuan on 13/05/2022.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    public func downloadImageWithCaching(with url: String,placeholderImage: UIImage? = nil, completion: (() -> Void)? = nil) {
        if url == ""{
            self.image = placeholderImage
            return
        }
        guard let imageURL = URL.init(string: url) else{
            self.image = placeholderImage
            return
        }
        self.kf.setImage(with: imageURL, placeholder: placeholderImage, options: [.transition(.fade(0.1))], progressBlock: nil, completionHandler: { (image, error, cacheType, _url) in
            //self.image = image
            completion?()
        })
    }
}
