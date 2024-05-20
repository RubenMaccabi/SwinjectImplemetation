//
//  FavoriteViewControllerCoordinator.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 26/03/2024.
//

import Foundation
import UIKit

class FavoriteViewControllerCoordinator: GiphySceneCoordinator {
    
    var children: [any GiphySceneCoordinator]
    internal let navigationController: UINavigationController
    private let favoriteVM: FavoriteViewController.ViewModel
    var viewController: UIViewController!
    
    init(navigationController: UINavigationController, favoriteVM: FavoriteViewController.ViewModel) {
        self.navigationController = navigationController
        self.children = []
        self.favoriteVM = favoriteVM
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true)
    }
    
    func start()  {
        navigationController.present(UINavigationController(rootViewController: viewController), animated: true)
    }
}
