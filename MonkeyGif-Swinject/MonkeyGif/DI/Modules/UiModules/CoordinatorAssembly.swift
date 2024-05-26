//
//  CoordinatorAssembly.swift
//  MonkeyGif
//
//  Created by Ruben  on 16/05/2024.
//

import Foundation
import DIWrapper
import UIKit

let favoriteCoordinatorContainer = AssemblyContainer(scope: .weak, name: FavoriteViewController.name, type: GiphySceneCoordinator.self) { r in
    let root = r.resolving(UINavigationController.self)
    let favoriteVM = r.resolving((any FetchingViewModelProtocol).self, name: FavoriteViewController.name) as? FavoriteViewController.ViewModel
    assert(favoriteVM != nil, "\(FavoriteViewController.ViewModel.self) not injected" )
    return FavoriteViewControllerCoordinator(navigationController: root, favoriteVM: favoriteVM!)
} circularDependency: { r, coordinator in
    let vc = r.resolving(FavoriteViewController.self)
    coordinator.viewController = vc
}

let appCoordinatorContainer = AssemblyContainer(scope: .weak, name:  AppViewController.name, type: GiphySceneCoordinator.self) { r in
    let appKeys = r.resolving(AppKeys.self)
    let interactor = r.resolving(ApiInteractorProtocol.self)
    let factory = r.resolving(ViewControllerFactory.self)
    let root = r.resolving(UINavigationController.self)
    let favoriteVCCoordinator = r.resolving(GiphySceneCoordinator.self, name: FavoriteViewController.name)
    
    let appCoordinator = AppViewControllerCoordinator (
        navigationController: root,
        appKeys: appKeys,
        apiInteractor: interactor,
        children: [favoriteVCCoordinator]
    )
    return appCoordinator
} circularDependency: { r, coordinator in
    let vc = r.resolving(AppViewController.self)
    coordinator.viewController = vc
}
