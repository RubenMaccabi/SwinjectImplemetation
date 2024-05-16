//
//  PlistDecodable.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 21/03/2024.
//

import Foundation

protocol PlistDecodable: Codable {}

struct AppKeys: PlistDecodable {
    let giphyApi: String
}

struct EndPoints: PlistDecodable {
    let trending: String
    let search: String
    let getById: String
    let host: String
    let scheme: String
}
