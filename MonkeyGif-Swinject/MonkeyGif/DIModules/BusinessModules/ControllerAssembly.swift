//
//  ControllerAssembly.swift
//  MonkeyGif
//
//  Created by Ruben  on 16/05/2024.
//

import Foundation
import Swinject
import UIKit

class ControllerAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(PersistenceController.self) { _ in
            PersistenceController.shared
        }
        .inObjectScope(.container)
        
        container.register(GifControllerProtocol.self) { r in
                GifController(controller: r.resolve(PersistenceController.self)!)
        }
    }
}
