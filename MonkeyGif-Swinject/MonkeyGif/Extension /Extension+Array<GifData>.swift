//
//  Extension+Array<GifData>.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 02/04/2024.
//

import Foundation

extension Array where Element == GifData {
    init(_ data: [Element]) {
        if data.isEmpty {
            self = [.init()]
        } else {
            self = data
        }
    }
}
