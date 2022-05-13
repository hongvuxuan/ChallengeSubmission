//
//  MainEntity.swift
//  LogicTest
//
//  Created by Hong Vu Xuan on 10/05/2022.
//

import Foundation

public enum TestEntityType {
    case test1
    case test2
    
    public var title: String {
        switch self {
        case .test1:
            return "Test 1"
        case .test2:
            return "Test 2"
        }
    }
    
    public var description: String {
        switch self {
        case .test1:
            return "Find the index that has the sum of left’s elements equal to the sum of right’s elements"
        case .test2:
            return "Detect that incoming string is palindrome or not"
        }
    }
    
    public var details: String {
        switch self {
        case .test1:
            return """
1. Please write a function to find the index that has the sum of left’s elements equal to the sum of right’s elements.
Example 1: input => [1, 3, 5, 7, 9] output => “middle index is 3”
Example 2: input => [3, 6, 8, 1, 5, 10, 1, 7] output => “middle index is 4”
Example 3: input => [3, 5, 6] output => “index not found”

Note: Please use only the basic programming function like if-else, loop, etc. 
"""
        case .test2:
            return """
2. Please write a function to detect that incoming string is palindrome or not  
Example 1: input => “aka”, output => “aka is a palindrome”
Example 2: input => “Level”, output => “Level is a palindrome”
Example 3: input => “Hello”, output => “Hello isn’t a palindrome”

Note: Please use only the basic programming function like if-else, loop, etc. 
"""
        }
    }
}

public struct TestEntity {
    public var type: TestEntityType
    
    public init(type: TestEntityType) {
        self.type = type
    }
}

public class MainEntities {
    var entity: TestEntity
    var testRepositories: [TestEntity] = []
    
    init(entity: TestEntity) {
        self.entity = entity
    }
}
