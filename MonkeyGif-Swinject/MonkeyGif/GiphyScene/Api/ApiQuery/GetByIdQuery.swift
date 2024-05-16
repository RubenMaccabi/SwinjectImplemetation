//
//  GetByIdQuery.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 19/03/2024.
//

import Foundation

struct GetByIdQuery: ApiQueryProtocol {
    let apiKey: String
    let gifId: String
    let path: String
    let rating: String // g, pg, pg-13, r
    
    init(apiKey: String,
         gifId: String,
         path: String,
         rating: String = "g") {
        self.apiKey = apiKey
        self.rating = rating
        self.gifId = gifId
        let _path = path.appending(gifId)
        self.path = _path
    }
    
    func toUrlComponents() -> URLComponents  {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: apiKey)
        urlComponents.queryItems = [apiKeyQueryItem]
        return urlComponents
    }
}
