//
//  ViewControllerProtocol.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 26/03/2024.
//

import Foundation

protocol ViewControllerProtocol: AnyObject {
    associatedtype Coordinator: GiphySceneCoordinator
    associatedtype ViewModel: FetchingViewModelProtocol
    var coordinator: Coordinator { get set }
    var viewModel: ViewModel { get set }
    func setupUI()
    func observeDataChanges()
    static func build(coordinator: Coordinator, viewModel: ViewModel) -> Self
}
