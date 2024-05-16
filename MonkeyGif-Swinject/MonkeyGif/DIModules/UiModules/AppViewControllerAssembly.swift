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
        
        container.register(AppViewController.self) { r in
            let vm = r.resolve(AppViewControllerViewModel.self)
            let coordinator = r.resolve(GiphySceneCoordinator.self)
            return AppViewController(viewModel: vm!, coordinator: coordinator as! AppViewControllerCoordinator)
        }
    }
    
}
