//
//  ApiQueryProtocol.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 19/03/2024.
//

import Foundation

protocol ApiQueryProtocol {
    var apiKey: String { get }
    var path: String { get }
    func toUrlComponents() -> URLComponents
}


extension ApiQueryProtocol {
    
    var endPoints: EndPoints {
        let reader = PlistReader(keyList: .endPoint)
        return reader.read()
    }
    
    var scheme: String {
        endPoints.scheme
    }
    var host: String {
        endPoints.host
    }
    
    var url: URL? {
        let components = toUrlComponents()
        return if let url = components.url {
            url
        } else {
            nil
        }
    }
}
