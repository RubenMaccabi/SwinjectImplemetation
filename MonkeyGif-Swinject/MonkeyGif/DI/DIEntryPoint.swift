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
        .add(FavoriteViewModelAssembly())
    // MARK: - ViewControllers
        .add(AppViewControllerAssembly())
        .add(FavoriteViewModelAssembly())
    // MARK: - Businness
        .add(AppViewControllerAssembly())
        .add(InteractorAssembly())
        .add(RepositoryAssembly())
        .add(ControllerAssembly())
    // MARK: - Routes
        .add(CoordinatorAssembly())
        .makeAssembler { di in
            let coordinator = di.resolve(GiphySceneCoordinator.self)
            coordinator.start()
            return coordinator.navigationController
        }
}

