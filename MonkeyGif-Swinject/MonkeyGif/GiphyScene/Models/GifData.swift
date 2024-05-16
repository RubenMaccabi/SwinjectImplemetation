//
//  GifData.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 21/03/2024.
//

import Foundation
import CoreData

struct GifData {
    let imageId: UUID
    let url: URL
    let isFavorite: Bool
    let isEmpty: Bool
    
    init(imageId: UUID, url: URL?, isFavorite: Bool) throws {
        self.imageId = imageId
        self.isFavorite = isFavorite
        self.isEmpty = false
        guard let url = url else {
            throw AppError.url(description: "URL is not valie at \(#function)")
        }
        self.url = url
    }
    
    init(isEmpty: Bool = true) {
        self.imageId = .init()
        self.url = Bundle.main.bundleURL
        self.isFavorite = false
        self.isEmpty = isEmpty
    }
    
    func toGifModel(context: NSManagedObjectContext) -> MGGif {
        MGGif(context: context, isFavorite: isFavorite, url: url, imageID: imageId)
    }
}
