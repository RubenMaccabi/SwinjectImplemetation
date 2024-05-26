//
//  InteractorAssembly.swift
//  MonkeyGif
//
//  Created by Ruben  on 16/05/2024.
//

import Foundation
import DIWrapper

let interactorContainer = AssemblyContainer(scope: .weak, type: ApiInteractorProtocol.self) { r in
    let repository = r.resolving(GifRepositoryProtocol.self)
    return ApiInteractor(repository: repository)
}
