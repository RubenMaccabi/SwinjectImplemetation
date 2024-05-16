//
//  KeyReader.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 19/03/2024.
//

import Foundation


enum KeyListValues: String {
    case appKeys = "AppKeys"
    case endPoint = "Endpoints"
}

struct PlistReader {
    private let keyList: KeyListValues
    
    init(keyList: KeyListValues) {
        self.keyList = keyList
    }
    
    func read<T: PlistDecodable>() -> T {
        guard let plistURL = Bundle.main.url(forResource: keyList.rawValue, withExtension: "plist") else {
            fatalError("Couldn't find \(keyList.rawValue).plist file")
        }
        do {
            let data = try Data(contentsOf: plistURL)
            let decoder = PropertyListDecoder()
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch {
            fatalError("\(keyList.rawValue) list does not fit decoding requirements")
        }
    }
}
