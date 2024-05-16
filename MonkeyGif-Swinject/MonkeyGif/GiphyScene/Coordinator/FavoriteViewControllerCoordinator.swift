//
//  FavoriteViewControllerCoordinator.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 26/03/2024.
//

import Foundation
import UIKit

class FavoriteViewControllerCoordinator: GiphySceneCoordinator {
    
    weak var parent: GiphySceneCoordinator?
    let navigationController: UINavigationController
    
    init(parent: GiphySceneCoordinator?, navigationController: UINavigationController) {
        self.parent = parent
        self.navigationController = navigationController
    }
    
    func dismiss() {
        precondition(parent != nil, "Favorite view condtroller must have a parent")
        parent?.dismiss()
    }
    
    func start() {
        let favoriteVC = FavoriteViewController(viewModel: .init(viewContext: PersistenceController.shared.container.viewContext), coordinator: self)
        let vc = UINavigationController(rootViewController: favoriteVC)
        navigationController.present(vc, animated: true)
    }
}
