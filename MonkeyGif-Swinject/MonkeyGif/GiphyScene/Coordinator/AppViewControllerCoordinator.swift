//
//  AppViewControllerCoordinator.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 26/03/2024.
//

import Foundation
import UIKit

class AppViewControllerCoordinator: GiphySceneCoordinator {
    
    weak var parent: GiphySceneCoordinator?
    var children: [GiphySceneCoordinator]
    let navigationController: UINavigationController
    let appKeys: AppKeys
    let apiInteractor: ApiInteractorProtocol
    var viewController: UIViewController!
    
    init(navigationController: UINavigationController,
         appKeys: AppKeys,
         apiInteractor: ApiInteractorProtocol,
         children: [GiphySceneCoordinator]) {
        self.parent = nil
        self.appKeys = appKeys
        self.children = children
        self.navigationController = navigationController
        self.apiInteractor = apiInteractor
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true)
    }
    
    func start() {
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    func showFavorites() {
        if let coordinator = children.first(where: { $0 is FavoriteViewControllerCoordinator}) {
            coordinator.start()
        }
    }
}
