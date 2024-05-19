//
//  CoordinatorAssembly.swift
//  MonkeyGif
//
//  Created by Ruben  on 16/05/2024.
//

import Foundation
import Swinject
import UIKit

class CoordinatorAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(FavoriteViewController.Coordinator.self) { r in
            let root = r.resolve(UINavigationController.self)!
            let favoriteVM = r.resolve(FavoriteViewController.ViewModel.self)!
            return FavoriteViewControllerCoordinator(navigationController: root, favoriteVM: favoriteVM)
        }
        .inObjectScope(.weak)
        
        container.register(GiphySceneCoordinator.self) { r in
            let appKeys = r.resolve(AppKeys.self)
            assert(appKeys != nil, "AppKeys not injected")
            let interactor = r.resolve(ApiInteractorProtocol.self)
            assert(interactor != nil, "ApiInteractorProtocol not injected")
            let factory = r.resolve(ViewControllerFactory.self)
            assert(factory != nil, "ViewControllerFactory not injected")
            let root = r.resolve(UINavigationController.self)
            assert(root != nil, "Root NavigationController not assembly not injected")
            let favoriteVCCoordinator = r.resolve(FavoriteViewController.Coordinator.self)
            assert(favoriteVCCoordinator != nil, "FavoriteViewController.Coordinator not injected")

           let appCoordinator = AppViewControllerCoordinator(
                navigationController: root!,
                appKeys: appKeys!,
                apiInteractor: interactor!,
                factory: factory!,
                children: [favoriteVCCoordinator!]
            )
            return appCoordinator
        }
        .inObjectScope(.container)
    }
}

