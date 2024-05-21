//
//  FavoriteViewControllerAssembly.swift
//  MonkeyGif
//
//  Created by Ruben  on 19/05/2024.
//

import Foundation
import DIWrapper

var favoriteViewControllerContainer = AssemblyContainer(scope: .graph) { r in
    let vm = r.resolving(FetchingVM.self, name: FavoriteViewController.name) as? FavoriteViewController.ViewModel
    assert(vm != nil,"\(FavoriteViewController.ViewModel.self) is not injected" )
    let coordinator = r.resolving(GiphySceneCoordinator.self, name: FavoriteViewController.name) as? FavoriteViewController.Coordinator
    assert(coordinator != nil,"\(FavoriteViewController.Coordinator.self) is not injected" )
    return FavoriteViewController(viewModel: vm!, coordinator: coordinator!)
}
