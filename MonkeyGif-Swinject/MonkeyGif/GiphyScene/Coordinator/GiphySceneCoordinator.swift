//
//  SceneCoordinator.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 26/03/2024.
//

import Foundation
import UIKit

protocol GiphySceneCoordinator: AnyObject {
    var navigationController: UINavigationController { get }
    var children: [GiphySceneCoordinator] { get set }
    func dismiss()
    func start()
}
