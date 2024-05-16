//
//  URLProtocolMock.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 01/04/2024.
//

import Foundation

class URLProtocolMock: URLProtocol {
    
    var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?)) {
        return {  request  in
            let testURLs : [URL?: Data] = [
                URL(string: "http://api.giphy.com/v1/gifs/search?api_key=DcUNF908rOYRCIz5PneEqOJAL6g4LSNF&limit=50&offset=0&rating=g&q=Food")! : searchMock.data(using: .utf8)!,
                URL(string: "http://api.giphy.com/v1/gifs/trending?api_key=DcUNF908rOYRCIz5PneEqOJAL6g4LSNF&limit=50&offset=0&rating=g")! : trendingMocks.data(using: .utf8)!,
                URL(string: "http://api.giphy.com/v1/gifs/xT4uQulxzV39haRFjG?api_key=DcUNF908rOYRCIz5PneEqOJAL6g4LSNF")! : getByidsMock.data(using: .utf8)!,
            ]
            return (HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!, testURLs[request.url!] ?? nil)
        }
    }
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        let (response, data) = try! requestHandler(request)
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        
        if let data = data {
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        }
    }
    
    override func stopLoading() {}
}
