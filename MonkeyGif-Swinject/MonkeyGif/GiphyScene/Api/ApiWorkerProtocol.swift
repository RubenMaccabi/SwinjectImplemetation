//
//  ApiWorkerProtocol.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 19/03/2024.
//

import Foundation

protocol ApiWorkerProtocol {
    associatedtype Query: ApiQueryProtocol
    associatedtype GifyResult: Codable
    var query: Query { get }
}

extension ApiWorkerProtocol {
    func fetch(session: URLSession = .shared) async -> Result<GifyResult,AppError> {
        guard let url = query.url else { return .failure(.url(description: "Could not build url with query")) }
        print(#function, url)
        do {
            let (data, urlResponse) = try await session.data(from: url)
            let response = urlResponse as! HTTPURLResponse
            switch response.statusCode {
            case 200...300:
                //print(#function, "Request success")
                break
            case 400..<500:
                print("400", response.statusCode)
                return .failure(.httpError(description: response.statusCode))
            case 500...:
                print("Server Error: Internal Server Error")
                return .failure(.httpError(description: response.statusCode))
            default:
                print("Unhandled status code: \(response.statusCode)")
            }
            let giphyData = try JSONDecoder().decode(GifyResult.self, from: data)
            return .success(giphyData)
        } catch {
            print(error)
            return .failure(.decoding(description: error.localizedDescription))
        }
    }
}
