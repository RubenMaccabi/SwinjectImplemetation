//
//  AppViewControllerViewModel.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 20/03/2024.
//

import Foundation
import Combine
import CoreData
import UIKit

class AppViewControllerViewModel: FetchingViewModelProtocol {
        
    private let apiKey: String
    private let interactor: ApiInteractorProtocol
    private var currentCount: Int
    @Published var searchState: SearchState
    @Published var searchText: String?
    @Published var fetchState: FetchState<[GifData]>
    
    var endPoints: EndPoints {
        let reader = PlistReader(keyList: .endPoint)
        return reader.read()
    }
    
    init(apiKey: String, interactor: ApiInteractorProtocol) {
        self.apiKey = apiKey
        self.interactor = interactor
        self.currentCount = 0
        self.fetchState = .idle
        self.searchState = .global
        observeSearch()
    }
    
    func addToFavorite(_ gif: GifData) {
        Task {
            do {
                try await interactor.save(gif)
            } catch {
                fetchState = .failure(.coreData(description: error.localizedDescription))
            }
        }
    }
    
    func observeSearch() {
        Task { [weak self] in
            guard let self = self else { return }
            let result = self.$searchText
                .compactMap { $0 }
                .filter { !$0.isEmpty }
                .debounce(for: 0.8, scheduler: DispatchQueue.main)
                .values
                .map { search in
                    switch self.searchState {
                    case .global:
                        var querySearch = search
                        #if !CANCALL
                            querySearch = "Food"
                        #endif
                        return await self.interactor.searchGif(.init(apiKey: self.apiKey, path: self.endPoints.search, limit: 50, q: querySearch, offset: 0))
                    case .byId:
                        return await self.interactor.getGifById(.init(apiKey: self.apiKey, gifId: search, path: self.endPoints.getById))
                    }
                }
            for await r in result {
                switch r {
                case .success(let success):
                    self.fetchState = .fetched(success)
                case .failure(let failure):
                    self.fetchState = .failure(failure)
                }
            }
        }
    }
    
    func updateTrendingScroll() {
        Task {[weak self] in
            guard let self = self else { return }
            let result =  await interactor.fetchTrending(.init(apiKey: apiKey, path: endPoints.trending, limit: 50, offset: currentCount))
            switch result {
            case .success(let success):
                if case let .fetched(data) = self.fetchState {
                    self.fetchState = .fetched(success+data)
                } else {
                    self.fetchState = .fetched(success)
                }
                #if CANCALL
                self.currentCount += 50
                #endif
            case .failure(let failure):
                self.fetchState = .failure(failure)
            }
        }
    }
    
    func toggleSearchState() {
        searchState = searchState == .global ? .byId : .global
    }
}


