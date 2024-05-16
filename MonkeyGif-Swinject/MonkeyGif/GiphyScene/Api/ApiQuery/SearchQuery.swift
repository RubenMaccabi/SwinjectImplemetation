//
//  SearchQuery.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 19/03/2024.
//

import Foundation

struct SearchQuery: ApiQueryProtocol {
    let apiKey: String
    let path: String
    let q: String
    let limit: Int
    let offset: Int
    let rating: String // g, pg, pg-13, r
    let lang: String
    
    init(apiKey: String,
         path: String,
         limit: Int,
         q: String,
         offset: Int,
         rating: String = "g",
         lang: String = "en") {
        self.apiKey = apiKey
        self.path = path
        self.limit = limit
        self.offset = offset
        self.rating = rating
        self.lang = lang
        self.q = q
    }
    
    func toUrlComponents() -> URLComponents  {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: apiKey)
        let limitQueryItem = URLQueryItem(name: "limit", value: "\(limit)")
        let offsetQueryItem = URLQueryItem(name: "offset", value: "\(offset)")
        let ratingQueryItem = URLQueryItem(name: "rating", value: rating)
        let queryQueryItem = URLQueryItem(name: "q", value: q)
        urlComponents.queryItems = [apiKeyQueryItem, limitQueryItem, offsetQueryItem, ratingQueryItem, queryQueryItem]
        return urlComponents
    }
}
