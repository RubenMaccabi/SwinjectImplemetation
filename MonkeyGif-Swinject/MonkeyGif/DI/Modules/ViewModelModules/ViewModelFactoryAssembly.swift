//
//  ViewModelAssembly.swift
//  MonkeyGif
//
//  Created by Ruben  on 16/05/2024.
//

import Foundation
import DIWrapper

var viewModelFactoryContainer = AssemblyContainer(scope: .container, type: ViewModelFactory.self) { _ in
    ViewModelFactoryImpl()
}
