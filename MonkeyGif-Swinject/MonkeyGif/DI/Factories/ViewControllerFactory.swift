//
//  ViewControllerFactory.swift
//  MonkeyGif
//
//  Created by Ruben  on 16/05/2024.
//

import Foundation
import UIKit

protocol ViewControllerFactory: AnyObject {
    func makeAppViewController<
        Coordinator: GiphySceneCoordinator,
        ViewController: ViewControllerProtocol
    >(
        vm: ViewController.ViewModel,
        coordinator: Coordinator
    ) -> ViewController where Coordinator == ViewController.Coordinator
}

final class ViewControllerFactoryImpl: ViewControllerFactory {
    
    func makeAppViewController<
        Coordinator: GiphySceneCoordinator,
        ViewController: ViewControllerProtocol
    >(
        vm: ViewController.ViewModel,
        coordinator: Coordinator
    ) -> ViewController where Coordinator == ViewController.Coordinator {
        ViewController.build(coordinator: coordinator, viewModel: vm)
    }
}
