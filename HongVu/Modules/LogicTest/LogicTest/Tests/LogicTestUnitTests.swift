//
//  LogicTestUnitTests.swift
//  LogicTest
//
//  Created by Hong Vu Xuan on 13/05/2022.
//

import XCTest
@testable import VIPER
@testable import LogicTest

class LogicTestUnitTests: XCTestCase {
    
    var interator: Test1Interactor?
    var presenter = MockPresenter()
    
    override func setUp() {
        interator = Test1Interactor()
        interator?.presenter = presenter
    }
    
    override func tearDown() {
        interator = nil
    }
    
    func test_middleIndex_Found() {
        // Given
        let array1 = [1,3,5,7,9]
        
        // When
        interator?.findTheMiddleIndex(array: array1)
        
        // Then
        XCTAssertEqual(presenter.middleIndex, 3)
    }
    
    func test_middleIndex_NotFound() {
        // Given
        let array1 = [1,3,5,7,9,7]
        
        // When
        interator?.findTheMiddleIndex(array: array1)
        
        // Then
        XCTAssertEqual(presenter.middleIndex, nil)
    }
    
    func test_is_Palimdrome() {
        // Given
        let string = "LeVEl"
        
        // When
        interator?.checkPalindrome(string)
        
        // Then
        XCTAssertEqual(presenter.isPalimdrome, true)
    }
    
    func test_isNot_Palimdrome() {
        // Given
        let string = "LeVEle"
        
        // When
        interator?.checkPalindrome(string)
        
        // Then
        XCTAssertEqual(presenter.isPalimdrome, false)
    }
}

class MockPresenter: Test1InteractorOutputs {
    
    var middleIndex: Int?
    var isPalimdrome: Bool = false
    
    func onResultFindTheMiddleIndex(index: Int?, value: Int?) {
        self.middleIndex = index
    }
    
    func onResultCheckPalindrome(string: String, isPalimdrome: Bool) {
        self.isPalimdrome = isPalimdrome
    }
}
