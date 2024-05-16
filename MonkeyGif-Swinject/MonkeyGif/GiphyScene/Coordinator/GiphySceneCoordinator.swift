//
//  SceneCoordinator.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 26/03/2024.
//

import Foundation
import UIKit

protocol GiphySceneCoordinator: AnyObject {
    var parent: GiphySceneCoordinator? { get set}
    var navigationController: UINavigationController { get }
    func dismiss()
    func start()
}
