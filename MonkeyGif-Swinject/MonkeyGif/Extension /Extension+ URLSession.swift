//
//  Extension+ URLSession.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 23/03/2024.
//

import Foundation

extension URLSession {
    
    static var mock: URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        return session
    }
    
    static var envSession: URLSession {
#if TEST || UIDEBUG
        return Self.mock
#else
        return Self.shared
#endif
    }
}
