//
//  DetailEntities.swift
//  CodingTest
//
//  Created by Hong Vu Xuan on 13/05/2022.
//

import Foundation

struct DetailEntryEntity {
    let articleRepository: ArticleRepository
}

struct DetailEntities {
    let title: String = "Details"
    let entryEntity: DetailEntryEntity
}
