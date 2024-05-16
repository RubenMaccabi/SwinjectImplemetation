//
//  GifRepository.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 20/03/2024.
//

import Foundation
import CoreData

protocol GifRepositoryProtocol {
    var controller: GifControllerProtocol { get }
    func save(_ gifData: [GifData]) async throws
    func fetchTrending(_ query: TrendingQuery) async -> GifDataResult
    func getGifById(_ query: GetByIdQuery) async -> GifDataResult
    func searchGif(_ query: SearchQuery)  async -> GifDataResult
}

struct GifRepository: GifRepositoryProtocol {
    
    let controller: GifControllerProtocol
    let urlSession: URLSession
    
    init(controller: GifControllerProtocol, urlSession: URLSession) {
        self.controller = controller
        self.urlSession = urlSession
    }
    
    func save(_ gifData: [GifData]) async throws {
        try await controller.save(gifData)
    }
    
    func fetchTrending(_ query: TrendingQuery) async -> GifDataResult{
        let trendingApi = TrendingApi(query: query)
        let result =  await trendingApi.fetch(session: urlSession)
        return handleResult(result: result)
    }
    
    func getGifById(_ query: GetByIdQuery) async -> GifDataResult {
        let getByIdApi = GetByIdApi(query: query)
        let result = await getByIdApi.fetch(session: urlSession)
        return handleResult(result: result)
    }
    
    func searchGif(_ query: SearchQuery) async -> GifDataResult {
        let searchApi = SearchQueryApi(query: query)
        let result = await searchApi.fetch(session: urlSession)
        return handleResult(result: result)
    }
    
    private func handleResult<T: GifyFetchedData>(result: Result<T, AppError>) -> GifDataResult {
        switch result {
        case .success(let data):
            do {
                let gifData = try data.map()
                return .success(gifData)
            } catch {
                return .failure(.decoding(description: error.localizedDescription))
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
