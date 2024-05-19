//
//  ViewModelFactory.swift
//  MonkeyGif
//
//  Created by Ruben  on 16/05/2024.
//

import Foundation
import CoreData

protocol ViewModelFactory {
    func makeViewFavoriteVCViewModel(managedContext: NSManagedObjectContext) -> FavoriteViewControllerViewModel
    func makeAppViewModel(appKeys: AppKeys, interator: ApiInteractorProtocol) -> AppViewControllerViewModel
}

final class ViewModelFactoryImpl: ViewModelFactory {
    
    func makeViewFavoriteVCViewModel(managedContext: NSManagedObjectContext) -> FavoriteViewControllerViewModel {
        .init(viewContext: managedContext)
    }
    
    func makeAppViewModel(appKeys: AppKeys, interator: ApiInteractorProtocol) -> AppViewControllerViewModel {
        .init(apiKey: appKeys.giphyApi, interactor: interator)
    }
}
