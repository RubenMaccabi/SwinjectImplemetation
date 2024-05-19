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
    var navigationController: UINavigationController
    let appKeys: AppKeys
    let apiInteractor: ApiInteractorProtocol
    let factory: ViewControllerFactory
    
    init(navigationController: UINavigationController,
         appKeys: AppKeys,
         apiInteractor: ApiInteractorProtocol,
         factory: ViewControllerFactory,
         children: [GiphySceneCoordinator]) {
        self.parent = nil
        self.appKeys = appKeys
        self.children = children
        self.navigationController = navigationController
        self.apiInteractor = apiInteractor
        self.factory = factory
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true)
    }
    
    func start() {
        let appViewController: AppViewController = factory.makeAppViewController(vm: .init(apiKey: appKeys.giphyApi, interactor: apiInteractor), coordinator: self)
        navigationController.setViewControllers([appViewController], animated: true)
    }
    
    func showFavorites() {
        if let coordinator = children.first(where: { $0 is FavoriteViewControllerCoordinator}) {
            coordinator.start()
        }
    }
}
