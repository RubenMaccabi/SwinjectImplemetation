//
//  ViewControllerProtocol.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 26/03/2024.
//

import Foundation

protocol ViewControllerProtocol {
    associatedtype Coordinator
    var coordinator: Coordinator { get }
    func setupUI()
    func observeDataChanges()
}
