//
//  ApiInteractor.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 20/03/2024.
//

import Foundation

protocol ApiInteractorProtocol {
    func save(_ gif: GifData) async throws
    func fetchTrending(_ query: TrendingQuery) async -> GifDataResult
    func getGifById(_ query: GetByIdQuery) async -> GifDataResult
    func searchGif(_ query: SearchQuery)  async -> GifDataResult
}

struct ApiInteractor: ApiInteractorProtocol {
    
    private let repository: GifRepositoryProtocol
    
    init(repository: GifRepositoryProtocol) {
        self.repository = repository
    }

    func save(_ gif: GifData) async throws {
        try await repository.save([gif])
    }
    
    func fetchTrending(_ query: TrendingQuery) async -> GifDataResult{
        await repository.fetchTrending(query)
    }
    
    func getGifById(_ query: GetByIdQuery) async -> GifDataResult {
        await repository.getGifById(query)
    }
    
    func searchGif(_ query: SearchQuery)  async -> GifDataResult{
        await repository.searchGif(query)
    }
}
