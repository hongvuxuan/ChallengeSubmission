//
//  APITask.swift
//  CodingTest
//
//  Created by Hong Vu Xuan on 12/05/2022.
//

import Foundation

public enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

public protocol APIProtocol {
    
    func request(_ httpMethod: HttpMethod,
                 request: Request,
                 onSuccess: @escaping (Data, URLResponse?) -> Void,
                 onError: @escaping (Error) -> Void)
}

open class APITask: APIProtocol {
    
    public var httpHeader: [String: String]? = ["content-type": "application/json"]
    public var timeoutInterval: TimeInterval = 60
    public var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData
    static let apiTaskSession: URLSession = URLSession(configuration: URLSessionConfiguration.ephemeral)
    
    public init() {}
    
    public func request(_ httpMethod: HttpMethod,
                        request: Request,
                        onSuccess: @escaping (Data, URLResponse?) -> Void,
                        onError: @escaping (Error) -> Void) {
        let urlRequest = URLRequestCreator.create(httpMethod: httpMethod,
                                                  request: request,
                                                  header: httpHeader,
                                                  timeoutInterval: timeoutInterval,
                                                  cachePolicy: cachePolicy)
        let task = APITask.apiTaskSession.dataTask(with: urlRequest, completionHandler: {(data, response, error) in
            if let error = error {
                onError(error)
                return
            }
            if let responseError = APITask.check(response: response) {
                onError(responseError)
                return
            }
            guard let data = data else {
                onError(APIError.recieveNilBody)
                return
            }
            onSuccess(data, response)
        })
        task.resume()
    }
    
    static internal func check(response: URLResponse?) -> NSError? {
        guard let notNilResponse = response else {
            return createError(.recieveNilResponse, nil)
        }

        let httpResponse = notNilResponse as! HTTPURLResponse
        guard (200..<300) ~= httpResponse.statusCode else {
            return createError(.recieveErrorHttpStatus, ["statusCode": httpResponse.statusCode])
        }
        return nil
    }
    
    static func createError(_ code: APIError, _ info: [String: Any]?) -> NSError {
        return NSError(domain: "APIError", code: code.rawValue, userInfo: info)
    }
}



