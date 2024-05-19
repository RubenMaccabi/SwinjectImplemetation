//
//  AssembleWrapper.swift
//  MonkeyGif
//
//  Created by Ruben  on 16/05/2024.
//

import Foundation
import Swinject
import UIKit
import SwiftUI

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
            // MARK: - Core
            RootNavigationAssembly(),
            SessionAssembly(),
            AppKeysAssembly(),
            // MARK: - Factories
            ViewModelFactoryAssembly(),
            ViewControllerFactoryAssembly(),
            // MARK: - ViewModels
            ViewModelsAssembly(),
            FavoriteViewModelAssembly(),
            // MARK: - ViewControllers
            AppViewControllerAssembly(),
            InteractorAssembly(),
            RepositoryAssembly(),
            ControllerAssembly(),
            CoordinatorAssembly(),
        ])
    }
    
    func startApp() -> UINavigationController {
        let coordinator = assembler.resolver.resolve(GiphySceneCoordinator.self)!
        coordinator.start()
        return coordinator.navigationController
    }
    
    func startApp() -> some View {
        AssembledViewRepresentable(parent: self)
    }
    
    private struct AssembledViewRepresentable: UIViewControllerRepresentable {
        
        let parent: AssembleWrapper
                
        func makeUIViewController(context: Context) -> UIViewController {
            parent.startApp()
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            
        }
    }
}
