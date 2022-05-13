//
//  URLRequestCreator.swift
//  CodingTest
//
//  Created by Hong Vu Xuan on 12/05/2022.
//

import Foundation

public class URLRequestCreator {

    static func create(httpMethod: HttpMethod,
                       request: Request,
                       header: [String: String]?,
                       timeoutInterval: TimeInterval,
                       cachePolicy: URLRequest.CachePolicy) -> URLRequest {

        let urlRequest = NSMutableURLRequest()
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.timeoutInterval = timeoutInterval
        urlRequest.cachePolicy = cachePolicy
        if let httpHeader = header {
            httpHeader.forEach {
                urlRequest.setValue($0.1, forHTTPHeaderField: $0.0)
            }
        }
        if httpMethod == .get {
            urlRequest.url = URL(string: appendGetParameter(url: request.url, parameter: URLEncoder.encode(request.params())))
        } else {
            urlRequest.url = URL(string: request.url)
            urlRequest.httpBody = URLEncoder.encode(request.params()).data(using: String.Encoding.utf8, allowLossyConversion: false)
        }
        #if DEBUG
        debugRequest(with: urlRequest as URLRequest)
        #endif
        return urlRequest as URLRequest
    }

    static func appendGetParameter(url: String, parameter: String) -> String {
        let separator: String
        if url.contains("?") {
            if ["?", "&"].contains(url.suffix(1)) {
                separator = ""
            } else {
                separator = "&"
            }
        } else {
            separator = "?"
        }
        return [url, parameter].joined(separator: separator)
    }

    static private func debugRequest(with urlRequest: URLRequest) {
        let details: [String] = [
            "timeoutInterval: \(urlRequest.timeoutInterval)",
            "method: \(urlRequest.httpMethod ?? "")",
            "cachePolicy: \(urlRequest.cachePolicy)",
            "allHTTPHeaderFields: \(urlRequest.allHTTPHeaderFields ?? [:])",
            "body: \(String(data: urlRequest.httpBody ?? Data(), encoding: .utf8) ?? "")"
        ]
        let detail: String = details.joined(separator: ", ")
        print(#file, #function)
        print("Request: {url: \(urlRequest.url?.absoluteString ?? "")}")
        print("Request Detail: {\(detail)}")
    }
}
