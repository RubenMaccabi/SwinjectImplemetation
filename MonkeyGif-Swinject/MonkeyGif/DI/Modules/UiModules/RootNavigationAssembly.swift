//
//  RootNavigationAssembly.swift
//  MonkeyGif
//
//  Created by Ruben  on 19/05/2024.
//

import Foundation
import UIKit
import Swinject
import DIWrapper

let rootContainer = AssemblyContainer(scope: .container) { _ in
    UINavigationController()
}
