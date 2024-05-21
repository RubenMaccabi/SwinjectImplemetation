//
//  AppViewControllerAssembler.swift
//  MonkeyGif
//
//  Created by Ruben  on 16/05/2024.
//

import Foundation
import DIWrapper

var appViewControllerContainer = AssemblyContainer(scope: .graph) { r in
    let vm = r.resolving(FetchingVM.self, name: AppViewController.name) as? AppViewController.ViewModel
    assert(vm != nil,"\(AppViewController.ViewModel.self) is not injected" )
    let coordinator = r.resolving(GiphySceneCoordinator.self, name: AppViewController.name) as? AppViewController.Coordinator
    assert(coordinator != nil,"\(AppViewController.Coordinator.self) is not injected" )
    return AppViewController(viewModel: vm!, coordinator: coordinator!)
}

