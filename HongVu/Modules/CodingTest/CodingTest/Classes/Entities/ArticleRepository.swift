//
//  ArticleRepository.swift
//  CodingTest
//
//  Created by Hong Vu Xuan on 12/05/2022.
//

import Foundation

struct ArticleRepository: Codable {
    var source: SourceRepository?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}
