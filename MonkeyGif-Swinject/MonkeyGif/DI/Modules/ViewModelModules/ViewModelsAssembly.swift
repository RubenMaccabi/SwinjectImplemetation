//
//  ViewModelsAssembly.swift
//  MonkeyGif
//
//  Created by Ruben  on 16/05/2024.
//

import Foundation
import UIKit
import DIWrapper

typealias FetchingVM = (any FetchingViewModelProtocol)

var appViewModelContainer = AssemblyContainer(scope: .weak, name: AppViewController.name, type: FetchingVM.self) { r in
    let factory = r.resolving(ViewModelFactory.self)
    let appKeys = r.resolving(AppKeys.self)
    let interactor = r.resolving(ApiInteractorProtocol.self)
    return factory.makeAppViewModel(appKeys: appKeys, interator: interactor)
}

var favoriteViewModelContainer = AssemblyContainer(scope: .weak, name: FavoriteViewController.name, type: FetchingVM.self) { r in
    let factory = r.resolving(ViewModelFactory.self)
    let container = r.resolving(PersistenceController.self)
    return factory.makeViewFavoriteVCViewModel(managedContext: container.container.viewContext)
}

extension UIViewController {
 
    static var name: String {
        String(describing: Self.self)
    }
}
