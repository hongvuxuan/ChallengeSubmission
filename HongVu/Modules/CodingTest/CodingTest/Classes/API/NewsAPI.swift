//
//  NewsAPI.swift
//  CodingTest
//
//  Created by Hong Vu Xuan on 12/05/2022.
//

import Foundation

struct NewsAPI {
    
    private static var baseURL = "https://newsapi.org/"
    private static var apiKey = "96b3b5505731463899cd409a2f68dc71"
    
    struct ArticlesRequest: Request {
        var url: String {
            return baseURL + "v2/everything?"
        }
        let apiKey: String = NewsAPI.apiKey
        let q: String
        let from: String
        let to: String
        let sortBy: String = "popularity"
        let pageSize: Int
        let page: Int
        
        func params() -> [(key: String, value: String)] {
            return [
                (key: "apiKey", value: apiKey),
                (key: "q", value: q),
                (key: "from", value: from),
                (key: "to", value: to),
                (key: "sortBy", value: sortBy),
                (key: "pageSize", value: "\(pageSize)"),
                (key: "page", value: "\(page)"),
            ]
        }
    }
    
    func search(with request: ArticlesRequest,
                onSuccess: @escaping (ArticlesRepositoriesResponse) -> Void,
                onError: @escaping (Error) -> Void) {
        APITask().request(.get, request: request, onSuccess: { (data, session) in
            do {
                let response = try self.parse(data)
                onSuccess(response)
            } catch {
                onError(APIError.failedParse)
            }
        }, onError: onError)
    }
    
    private func parse(_ data: Data) throws -> ArticlesRepositoriesResponse {
        let response = try JSONDecoder().decode(ArticlesRepositoriesResponse.self, from: data)
        return response
    }
}
