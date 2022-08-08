//
//  NewsAPI.swift
//  CodingTest
//
//  Created by Hong Vu Xuan on 12/05/2022.
//

import Foundation

struct NewsAPI {
    
    private static var baseURL = "https://newsapi.org/"
    private static var apiKey = "55634192b82948888de6be3354230be2"
    
    private static var countriesSupported = ["ae", "ar", "at", "au", "be", "bg", "br", "ca", "ch", "cn", "co", "cu", "cz", "de", "eg", "fr", "gb", "gr", "hk", "hu", "id", "ie", "il", "in", "it", "jp", "kr", "lt", "lv", "ma", "mx", "my", "ng", "nl", "no", "nz", "ph", "pl", "pt", "ro", "rs", "ru", "sa", "se", "sg", "si", "sk", "th", "tr", "tw", "ua", "us", "ve", "za"]
    
    enum CategoriesSupported: String, CaseIterable {
        case business
        case entertainment
        case general
        case health
        case science
        case sports
        case technology
        
        var name: String {
            switch self {
            case .business:
                return "Business"
            case .entertainment:
                return "Entertainment"
            case .general:
                return "General"
            case .health:
                return "Health"
            case .science:
                return "Science"
            case .sports:
                return "Sports"
            case .technology:
                return "Technology"
            }
        }
    }
    
    private static var languagesSupported = ["ar", "de", "en", "es", "fr", "he", "it", "nl", "no", "pt", "ru", "sv", "ud", "zh"]
    
    enum SortBySupported: String, CaseIterable {
        case relevancy
        case popularity
        case publishedAt
    }
    
    struct ArticlesRequest: Request {
        
        enum EndPointType {
            case topHeadlines(category: CategoriesSupported.RawValue, country: String, q: String?, pageSize: Int, page: Int)
            case everything(q: String?, pageSize: Int, page: Int)
        }
        
        let endpointType: EndPointType
        
        var url: String {
            switch endpointType {
            case .topHeadlines(_, _, _, _, _):
                return baseURL + "v2/top-headlines?"
            case .everything:
                return baseURL + "v2/everything?"
            }
        }
        let apiKey: String = NewsAPI.apiKey
        let sortBy: String = "popularity"
        
        func params() -> [(key: String, value: String)] {
            switch endpointType {
            case .topHeadlines(let category, let country, let q, let pageSize, let page):
                return [
                    (key: "apiKey", value: apiKey),
                    (key: "category", value: category),
                    (key: "country", value: country),
                    (key: "pageSize", value: "\(pageSize)"),
                    (key: "page", value: "\(page)"),
                ]
            case .everything(let q, let pageSize, let page):
                return [
                    (key: "apiKey", value: apiKey),
                    (key: "q", value: q ?? ""),
                    (key: "searchIn", value: "title"),
                    (key: "sortBy", value: "popularity"),
                    (key: "pageSize", value: "\(pageSize)"),
                    (key: "page", value: "\(page)"),
                ]
            }
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
