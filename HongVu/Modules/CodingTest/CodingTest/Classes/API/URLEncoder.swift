//
//  URLEncoder.swift
//  CodingTest
//
//  Created by Hong Vu Xuan on 12/05/2022.
//

import Foundation

public class URLEncoder {
    
    public class func encode(_ parameters: [(key: String, value: String)]) -> String {
        let encodedString: String = parameters.compactMap {
            guard let value = $0.value.addingPercentEncoding(withAllowedCharacters: .alphanumerics) else {
                return nil
            }
            return "\($0.key)=\(value)"
        }.joined(separator: "&")
        return encodedString
    }
}
