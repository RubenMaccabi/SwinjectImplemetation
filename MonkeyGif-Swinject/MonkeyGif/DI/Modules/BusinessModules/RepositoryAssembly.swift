//
//  RepositoryAssembly.swift
//  MonkeyGif
//
//  Created by Ruben  on 16/05/2024.
//

import Foundation
import DIWrapper

var repositoryContainer = AssemblyContainer(scope: .weak, type: GifRepositoryProtocol.self) { r  in
    let controller = r.resolving(GifControllerProtocol.self)
    let session = r.resolving(URLSession.self)
    return GifRepository(controller: controller, urlSession: session)
}
