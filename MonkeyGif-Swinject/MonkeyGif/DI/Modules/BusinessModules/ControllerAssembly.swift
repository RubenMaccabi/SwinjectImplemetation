//
//  ControllerAssembly.swift
//  MonkeyGif
//
//  Created by Ruben  on 16/05/2024.
//

import Foundation
import DIWrapper

var persistenceControllerContainer = AssemblyContainer(scope: .container) { r in
    PersistenceController.shared
}

var gifControllerContainer = AssemblyContainer(scope: .weak, type: GifControllerProtocol.self) { r in
    GifController(controller: r.resolving(PersistenceController.self))
}
