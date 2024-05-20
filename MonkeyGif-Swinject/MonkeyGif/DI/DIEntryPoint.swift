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
        .add(RootNavigationAssembly())
        .add(SessionAssembly())
        .add(AppKeysAssembly())
    // MARK: - Factories
        .add(ViewModelFactoryAssembly())
        .add(ViewControllerFactoryAssembly())
    // MARK: - ViewModels
        .add(ViewModelsAssembly())
    // MARK: - ViewControllers
        .add(AppViewControllerAssembly())
        .add(FavoriteViewControllerAssembly())
    // MARK: - Businness
        .add(AppViewControllerAssembly())
        .add(InteractorAssembly())
        .add(RepositoryAssembly())
        .add(ControllerAssembly())
    // MARK: - Routes
        .add(CoordinatorAssembly())
        .makeAssembler { di in
            let coordinator = di.resolve(GiphySceneCoordinator.self, name: AppViewController.name)
            coordinator.start()
            return coordinator.navigationController
        }
}

