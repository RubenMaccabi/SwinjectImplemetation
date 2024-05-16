//
//  FetchingViewModel.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 22/03/2024.
//

import Foundation
import Combine

protocol FetchingViewModelProtocol: ObservableObject {
    associatedtype Fetched
    var fetchState: FetchState<Fetched> { get set }
}
