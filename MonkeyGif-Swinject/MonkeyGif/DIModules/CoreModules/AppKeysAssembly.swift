//
//  AppKeysAssembly.swift
//  MonkeyGif
//
//  Created by Ruben  on 16/05/2024.
//

import Foundation
import Swinject

class AppKeysAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(AppKeys.self) { _ in
            let reader = PlistReader(keyList: .appKeys)
            let appKeys: AppKeys = reader.read()
            return appKeys
        }
    }
}
