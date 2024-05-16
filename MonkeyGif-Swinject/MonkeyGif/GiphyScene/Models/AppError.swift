//
//  AppError.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 19/03/2024.
//

import Foundation

enum AppError: LocalizedError {
    case decoding(description: String)
    case url(description: String)
    case coreData(description: String)
    case httpError(description: Int)
}
