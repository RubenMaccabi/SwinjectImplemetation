//
//  ViewControllerAssembly.swift
//  MonkeyGif
//
//  Created by Ruben  on 16/05/2024.
//

import Foundation
import Swinject

class ViewControllerFactoryAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(ViewControllerFactory.self) { _ in
            ViewControllerFactoryImpl()
        }
        .inObjectScope(.container)
    }
}
