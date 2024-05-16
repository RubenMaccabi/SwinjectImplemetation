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
    let navigationController: UINavigationController
    let apiKey: String
    let apiInteractor: ApiInteractorProtocol
    
    init(navigationController: UINavigationController, apiKey: String, apiInteractor: ApiInteractorProtocol) {
        self.parent = nil
        self.apiKey = apiKey
        self.navigationController = navigationController
        self.apiInteractor = apiInteractor
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true)
    }
    
    func start() {
        let appViewController = AppViewController(viewModel: .init(apiKey: apiKey, interactor: apiInteractor), coordinator: self)
        navigationController.setViewControllers([appViewController], animated: true)
    }
    
    func showFavorites() {
        FavoriteViewControllerCoordinator(parent: self, navigationController: navigationController).start()
    }
}
