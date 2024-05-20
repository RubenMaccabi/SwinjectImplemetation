//
//  ViewModelsAssembly.swift
//  MonkeyGif
//
//  Created by Ruben  on 16/05/2024.
//

import Foundation
import Swinject
import UIKit

final class ViewModelsAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register((any FetchingViewModelProtocol).self, name: AppViewController.name) { r in
            let factory = r.resolve(ViewModelFactory.self)
            assert(factory != nil, "ViewModelFactory not injected")
            let appKeys = r.resolve(AppKeys.self)
            assert(appKeys != nil, "AppKeys not injected")
            let interactor = r.resolve(ApiInteractorProtocol.self)
            assert(interactor != nil, "ApiInteractor not injected")
            return factory!.makeAppViewModel(appKeys: appKeys!, interator: interactor!)
        }
        .inObjectScope(.weak)
        
        container.register((any FetchingViewModelProtocol).self, name: FavoriteViewController.name) { r in
            let factory = r.resolve(ViewModelFactory.self)
            assert(factory != nil, "ViewModelFactory not injected")
            let container = r.resolve(PersistenceController.self)!
            return factory!.makeViewFavoriteVCViewModel(managedContext: container.container.viewContext)
        }
        .inObjectScope(.weak)
    }
}


extension UIViewController {
 
    static var name: String {
        String(describing: Self.self)
    }
}
