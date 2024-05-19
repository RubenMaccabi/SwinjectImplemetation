//
//  SessionAssembly.swift
//  MonkeyGif
//
//  Created by Ruben  on 16/05/2024.
//

import Foundation
import Swinject

class SessionAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(URLSession.self) { _ in
                .envSession
        }
        .inObjectScope(.container)
    }
}
