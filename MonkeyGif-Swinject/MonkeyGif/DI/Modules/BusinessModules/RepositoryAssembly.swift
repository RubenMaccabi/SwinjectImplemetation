//
//  RepositoryAssembly.swift
//  MonkeyGif
//
//  Created by Ruben  on 16/05/2024.
//

import Foundation
import Swinject

final class RepositoryAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(GifRepositoryProtocol.self) { r in
            let controller = r.resolve(GifControllerProtocol.self)
            assert(controller != nil, "GifControllerProtocol not injected")
            let session = r.resolve(URLSession.self)
            assert(session != nil, "URLSession not injected")
            return GifRepository(controller: controller!, urlSession: session!)
        }
        .inObjectScope(.weak)
    }
    
}
