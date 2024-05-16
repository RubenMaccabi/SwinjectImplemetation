//
//  GetByIdWorker.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 19/03/2024.
//

import Foundation

struct GetByIdApi: ApiWorkerProtocol {
    
    typealias Query = GetByIdQuery
    typealias GifyResult = GiphyIDData
    
    let query: GetByIdQuery
    
    init(query: GetByIdQuery) {
        self.query = query
    }
}
