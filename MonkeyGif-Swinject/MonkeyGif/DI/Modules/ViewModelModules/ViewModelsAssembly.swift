//
//  ViewModelsAssembly.swift
//  MonkeyGif
//
//  Created by Ruben  on 16/05/2024.
//

import Foundation
import Swinject

final class ViewModelsAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register((any FetchingViewModelProtocol).self) { r in
            let factory = r.resolve(ViewModelFactory.self)
            assert(factory != nil, "ViewModelFactory not injected")
            let appKeys = r.resolve(AppKeys.self)
            assert(appKeys != nil, "AppKeys not injected")
            let interactor = r.resolve(ApiInteractor.self)
            assert(interactor != nil, "ApiInteractor not injected")
            return factory!.makeAppViewModel(appKeys: appKeys!, interator: interactor!)
        }
        .inObjectScope(.weak)
    }
}

