//
//  AppViewControllerAssembler.swift
//  MonkeyGif
//
//  Created by Ruben  on 16/05/2024.
//

import Foundation
import Swinject

final class AppViewControllerAssembly: Assembly {

    func assemble(container: Container) {
        container.register(AppViewController.self) { r in
            let vm = r.resolve((any FetchingViewModelProtocol).self, name: AppViewController.name) as? AppViewController.ViewModel
            assert(vm != nil,"\(AppViewController.ViewModel.self) is not injected" )
            let coordinator = r.resolve(GiphySceneCoordinator.self, name: AppViewController.name) as? AppViewController.Coordinator
            assert(coordinator != nil,"\(AppViewController.Coordinator.self) is not injected" )
            return AppViewController(viewModel: vm!, coordinator: coordinator!)
        }
        .inObjectScope(.graph)
    }
}
