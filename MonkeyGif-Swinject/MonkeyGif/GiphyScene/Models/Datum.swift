//
//  Datum.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 26/03/2024.
//

import Foundation

struct Datum: Codable {
    let images: Images?
}

extension Datum {
    func toGifData(offset: Int = -1) throws -> GifData {
        return try GifData(
            imageId: UUID(),
            url: images?.downsized?.url,
            isFavorite: false
        )
    }
}
