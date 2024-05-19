//
//  FavoriteViewControllerAssembly.swift
//  MonkeyGif
//
//  Created by Ruben  on 19/05/2024.
//

import Foundation
import Swinject

class FavoriteViewModelAssembly: Assembly {

    func assemble(container: Container) {
        container.register(FavoriteViewControllerViewModel.self) { r in
            let controller = r.resolve(PersistenceController.self)!
            return FavoriteViewControllerViewModel(viewContext: controller.container.viewContext)
        }
    }
}

