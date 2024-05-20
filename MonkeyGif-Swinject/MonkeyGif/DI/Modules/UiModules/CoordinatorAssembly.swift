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
        
        container.register(GiphySceneCoordinator.self, name: FavoriteViewController.name) { r in
            let root = r.resolve(UINavigationController.self)
            assert(root != nil, "\(UINavigationController.self) not injected")
            let favoriteVM = r.resolve((any FetchingViewModelProtocol).self, name: FavoriteViewController.name) as? FavoriteViewController.ViewModel
            assert(favoriteVM != nil, "\(FavoriteViewController.ViewModel.self) not injected" )
            return FavoriteViewControllerCoordinator(navigationController: root!, favoriteVM: favoriteVM!)
        }
        .initCompleted({ r, coordinator in
            let vc = r.resolve(FavoriteViewController.self)
            assert(vc != nil, "\(FavoriteViewController.self) not injected")
            coordinator.viewController = vc
        })
        .inObjectScope(.weak)
        
        container.register(GiphySceneCoordinator.self, name: AppViewController.name) { r in
            let appKeys = r.resolve(AppKeys.self)
            assert(appKeys != nil, "AppKeys not injected")
            let interactor = r.resolve(ApiInteractorProtocol.self)
            assert(interactor != nil, "ApiInteractorProtocol not injected")
            let factory = r.resolve(ViewControllerFactory.self)
            assert(factory != nil, "ViewControllerFactory not injected")
            let root = r.resolve(UINavigationController.self)
            assert(root != nil, "Root NavigationController not assembly not injected")
            let favoriteVCCoordinator = r.resolve(GiphySceneCoordinator.self, name: FavoriteViewController.name)
            assert(favoriteVCCoordinator != nil, "FavoriteViewController.Coordinator not injected")

           let appCoordinator = AppViewControllerCoordinator (
                navigationController: root!,
                appKeys: appKeys!,
                apiInteractor: interactor!,
                children: [favoriteVCCoordinator!]
            )
            return appCoordinator
        }
        .initCompleted({ r, coordinator in
            let vc = r.resolve(AppViewController.self)
            assert(vc != nil, "AppViewController not injected")
            coordinator.viewController = vc
        })
        .inObjectScope(.weak)
    }
}

