//
//  InteractorAssembly.swift
//  MonkeyGif
//
//  Created by Ruben  on 16/05/2024.
//

import Foundation
import Swinject

final class InteractorAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(ApiInteractorProtocol.self) { r in
            let repository = r.resolve(GifRepositoryProtocol.self)
            assert(repository != nil, "ApiInteractorProtocol not injected")
            return ApiInteractor(repository: repository!)
        }
        .inObjectScope(.weak)
    }
}
