//
//  FavoriteViewControllerAssembly.swift
//  MonkeyGif
//
//  Created by Ruben  on 19/05/2024.
//

import Foundation
import Swinject

final class FavoriteViewControllerAssembly: Assembly {

    func assemble(container: Container) {
        container.register(FavoriteViewController.self) { r in
            let vm = r.resolve((any FetchingViewModelProtocol).self, name: FavoriteViewController.name) as? FavoriteViewController.ViewModel
            assert(vm != nil,"\(FavoriteViewController.ViewModel.self) is not injected" )
            let coordinator = r.resolve(GiphySceneCoordinator.self, name: FavoriteViewController.name) as? FavoriteViewController.Coordinator
            assert(coordinator != nil,"\(FavoriteViewController.Coordinator.self) is not injected" )
            return FavoriteViewController(viewModel: vm!, coordinator: coordinator!)
        }
        .inObjectScope(.graph)
    }
}

