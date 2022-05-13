//
//  ArticlesRepository.swift
//  CodingTest
//
//  Created by Hong Vu Xuan on 12/05/2022.
//

import Foundation

struct ArticlesRepositoriesResponse: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [ArticleRepository]?
}
