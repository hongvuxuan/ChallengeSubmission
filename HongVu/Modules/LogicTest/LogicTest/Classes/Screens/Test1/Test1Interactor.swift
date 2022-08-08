//
//  Test1Interactor.swift
//  LogicTest
//
//  Created by Hong Vu Xuan on 11/05/2022.
//

import VIPER

protocol Test1InteractorOutputs: AnyObject {
    func onResultFindTheMiddleIndex(index: Int?, value: Int?)
    func onResultCheckPalindrome(string: String, isPalimdrome: Bool)
}

public class Test1Interactor: InteracterProtocol {
    
    weak var presenter: Test1InteractorOutputs?
    
    /*
     Form a Prefix and Suffix arrays, then traverse both prefix arrays.
     The index at which they yield equal result,
     is the index where the array is partitioned with equal sum
     */
    func findTheMiddleIndex(array: [Int]) {
        var returnIndex: Int? = nil
        var returnValue: Int? = nil
        
        let count = array.count
        
        if count <= 1 {
            presenter?.onResultFindTheMiddleIndex(index: 0, value: array[0])
            return
        }
        // Forming prefix sum array from 0
        var prefixSum = Array(repeating: 0, count: count)
        prefixSum[0] = array[0]
        for i in 1..<count {
            prefixSum[i] = prefixSum[i - 1] + array[i];
        }
        
        // Forming suffix sum array from n-1
        var suffixSum = Array(repeating: 0, count: count)
        suffixSum[count - 1] = array[count - 1]
        var i = count-2
        while i >= 0 {
            suffixSum[i] = suffixSum[i + 1] + array[i]
            i -= 1
        }
        
        // Find the point where prefix and suffix sum are same
        for i in 1..<count-1 {
            if prefixSum[i] == suffixSum[i] {
                returnIndex = i
                returnValue = array[i]
            }
        }
        
        presenter?.onResultFindTheMiddleIndex(index: returnIndex, value: returnValue)
    }
    
    func checkPalindrome(_ string: String, caseSensitive: Bool = true) {
        var returnIsPalindrome: Bool = true
        
        // Convert input string to array string
        var arrayString: [String] = []
        for c in string {
            if caseSensitive {
                arrayString.append(String(c).lowercased())
            } else {
                arrayString.append(String(c))
            }
        }
        
        // Start from leftmost and rightmost corners of string
        var leftmost = 0
        var rightmost = arrayString.count - 1
        
        // Keep comparing characters while they are same
        while rightmost > leftmost {
            if arrayString[leftmost] != arrayString[rightmost] {
                returnIsPalindrome = false
                break
            }
            leftmost += 1
            rightmost -= 1
        }

        presenter?.onResultCheckPalindrome(string: string, isPalimdrome: returnIsPalindrome)
    }
}
