//
//  ControllerAssembly.swift
//  MonkeyGif
//
//  Created by Ruben  on 16/05/2024.
//

import Foundation
import DIWrapper

let persistenceControllerContainer = AssemblyContainer(scope: .container) { r in
    PersistenceController.shared
}

let gifControllerContainer = AssemblyContainer(scope: .weak, type: GifControllerProtocol.self) { r in
    GifController(controller: r.resolving(PersistenceController.self))
}
