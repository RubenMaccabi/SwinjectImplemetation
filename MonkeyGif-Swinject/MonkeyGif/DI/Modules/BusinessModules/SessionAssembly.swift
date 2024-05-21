//
//  SessionAssembly.swift
//  MonkeyGif
//
//  Created by Ruben  on 16/05/2024.
//

import Foundation
import DIWrapper

var sessionContainer = AssemblyContainer(scope: .container) { _ in
    URLSession.envSession
}
