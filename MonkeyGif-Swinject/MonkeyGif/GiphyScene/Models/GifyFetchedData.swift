//
//  GifyFetchedData.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 26/03/2024.
//

import Foundation

protocol GifyFetchedData {
    associatedtype FetchData: Codable
    var data: FetchData { get }
    func map() throws -> [GifData]
}

struct GiphySearchData: Codable, GifyFetchedData {
    let data: [Datum]
    
    func map() throws -> [GifData] {
        try data.map { try $0.toGifData() }
    }
}

struct GiphyIDData: Codable, GifyFetchedData {
    let data: Datum
    
    func map() throws -> [GifData] {
        [try data.toGifData()]
    }
}
