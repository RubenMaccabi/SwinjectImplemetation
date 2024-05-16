//
//  GifController.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 21/03/2024.
//

import Foundation
import CoreData

protocol GifControllerProtocol {
    func save(_ gifData: [GifData]) async throws
}

struct GifController: GifControllerProtocol {
    
    let controller: PersistenceController
    
    init(controller: PersistenceController) {
        self.controller = controller
    }
    
    func save(_ gifData: [GifData]) async throws {
        let backgroundContext = controller.container.newBackgroundContext()
        await backgroundContext.perform {
            gifData.forEach { gif in
                _ = MGGif(context: backgroundContext, isFavorite: gif.isFavorite, url: gif.url, imageID: gif.imageId)
            }
            try? backgroundContext.save()
        }
    }
}
