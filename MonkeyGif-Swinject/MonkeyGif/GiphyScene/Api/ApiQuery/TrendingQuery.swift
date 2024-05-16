//
//  TrendingQuery.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 19/03/2024.
//

import Foundation

struct TrendingQuery: ApiQueryProtocol {
    let apiKey: String
    let path: String
    let limit: Int
    let offset: Int
    let rating: String // g, pg, pg-13, r
    
    init(apiKey: String,
         path: String,
         limit: Int = 5,
         offset: Int = 0,
         rating: String = "g") {
        self.apiKey = apiKey
        self.path = path
        self.limit = limit
        self.offset = offset
        self.rating = rating
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
        urlComponents.queryItems = [apiKeyQueryItem, limitQueryItem, offsetQueryItem, ratingQueryItem]
        return urlComponents
    }
}
