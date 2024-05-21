//
//  DIEntryPoint.swift
//  MonkeyGif
//
//  Created by Ruben  on 19/05/2024.
//

import Foundation
import DIWrapper

func buildDI() -> DiBuilder {
    let di: DI = .init()
    return di
    // MARK: - Core
        .add(rootContainer)
        .add(sessionContainer)
        .add(appkeysContainer)
    // MARK: - Factories
        .add(viewModelFactoryContainer)
        .add(viewControllerFactoryContainer)
    // MARK: - ViewModels
        .add(appViewModelContainer)
        .add(favoriteViewModelContainer)
    // MARK: - ViewControllers
        .add(appViewControllerContainer)
        .add(favoriteViewControllerContainer)
    // MARK: - Businness
        .add(interactorContainer)
        .add(repositoryContainer)
        .add(persistenceControllerContainer)
        .add(gifControllerContainer)
    // MARK: - Routes
        .add(favoriteCoordinatorContainer)
        .add(appCoordinatorContainer)
        .makeAssembler { di in
            let coordinator = di.resolve(GiphySceneCoordinator.self, name: AppViewController.name)
            coordinator.start()
            return coordinator.navigationController
        }
}

