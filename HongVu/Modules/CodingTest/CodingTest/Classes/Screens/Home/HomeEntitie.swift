//
//  HomeEntitie.swift
//  CodingTest
//
//  Created by Hong Vu Xuan on 12/05/2022.
//

import LogicTest

public class HomeEntities {
    
    let title: String = "News"
    
    struct ArticlesAPIState {
        var pageCount = 1
        var isFetching = false
    }
    
    struct Category {
        var type: NewsAPI.CategoriesSupported
        var selected: Bool
    }
    
    var entryEntity: TestEntity
    var articlesRepositories: [ArticleRepository] = []
    var articlesAPIState = ArticlesAPIState()
    var category: NewsAPI.CategoriesSupported = .general
    
    init(entryEntity: TestEntity) {
        self.entryEntity = entryEntity
    }
}
