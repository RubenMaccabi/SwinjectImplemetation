//
//  CoordinatorAssembly.swift
//  MonkeyGif
//
//  Created by Ruben  on 16/05/2024.
//

import Foundation
import Swinject

class CoordinatorAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(GiphySceneCoordinator.self) { r in
            let appKeys = r.resolve(AppKeys.self)
            assert(appKeys != nil, "AppKeys not injected")
            let interactor = r.resolve(ApiInteractorProtocol.self)
            assert(interactor != nil, "ApiInteractorProtocol not injected")
            let c = AppViewControllerCoordinator(
                navigationController: .init(),
                apiKey: appKeys!.giphyApi,
                apiInteractor: interactor!
            )
            c.start()
            return c
        }
        .inObjectScope(.container)
    }
}

