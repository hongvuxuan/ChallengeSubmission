//
//  APIError.swift
//  CodingTest
//
//  Created by Hong Vu Xuan on 12/05/2022.
//

import Foundation

public enum APIError: Int, Error {
    
    case recieveNilResponse = 0,
         recieveErrorHttpStatus,
         recieveNilBody,
         failedParse
}
