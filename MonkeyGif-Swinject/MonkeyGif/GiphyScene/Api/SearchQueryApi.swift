//
//  SearchProtocol.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 19/03/2024.
//

import Foundation

struct SearchQueryApi: ApiWorkerProtocol {
    typealias Query = SearchQuery
    typealias GifyResult = GiphySearchData
    
    let query: SearchQuery
    
    init(query: SearchQuery) {
        self.query = query
    }
}
