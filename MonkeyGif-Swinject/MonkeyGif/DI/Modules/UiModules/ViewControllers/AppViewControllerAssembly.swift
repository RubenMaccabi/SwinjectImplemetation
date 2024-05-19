//
//  AppViewControllerAssembler.swift
//  MonkeyGif
//
//  Created by Ruben  on 16/05/2024.
//

import Foundation
import Swinject

class AppViewControllerAssembly: Assembly {

    func assemble(container: Container) {
        
        container.register(AppViewControllerViewModel.self) { r in
            let interactor = r.resolve(ApiInteractorProtocol.self)
            let appKeys = r.resolve(AppKeys.self)
            return AppViewControllerViewModel(apiKey: appKeys!.giphyApi, interactor: interactor!)
        }
        .inObjectScope(.weak)
        
        container.register(AppViewController.self) { r in
            let vm = r.resolve(AppViewController.ViewModel.self)
            let coordinator = r.resolve(AppViewController.Coordinator.self)
            return AppViewController(viewModel: vm!, coordinator: coordinator!)
        }
    }
}
