//
//  ViewModelAssembly.swift
//  MonkeyGif
//
//  Created by Ruben  on 16/05/2024.
//

import Foundation
import Swinject

final class ViewModelFactoryAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(ViewModelFactory.self) { r in
            ViewModelFactoryImpl()
        }
        .inObjectScope(.container)
    }
}
