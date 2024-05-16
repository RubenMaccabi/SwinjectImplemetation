//
//  AssembleWrapper.swift
//  MonkeyGif
//
//  Created by Ruben  on 16/05/2024.
//

import Foundation
import Swinject
import UIKit

@Observable
class AssembleWrapper {
    
    let assembler: Assembler
    let uiEntryPoint: UIEntryPoint
    
    init(uiEntryPoint: UIEntryPoint) {
        self.uiEntryPoint = uiEntryPoint
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = UIColor.red
        uiEntryPoint.window = window
        assembler = .init([
            InteractorAssembly(),
            RepositoryAssembly(),
            ControllerAssembly(),
            SessionAssembly(),
            AppKeysAssembly(),
            CoordinatorAssembly(),
            AppViewControllerAssembly()
        ])
    }
    
    func startApp() -> UINavigationController {
        let vc = assembler.resolver.resolve(GiphySceneCoordinator.self)!
        return vc.navigationController
    }
}
