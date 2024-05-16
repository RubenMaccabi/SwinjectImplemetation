//
//  Extension+MGGif.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 20/03/2024.
//

import Foundation
import CoreData

extension MGGif {
    convenience init(context: NSManagedObjectContext,
                     isFavorite: Bool,
                     url: URL,
                     imageID: UUID
    ) {
        self.init(context: context)
        self.isFavourite = isFavorite
        self.url = url.absoluteString
        self.imageId = imageID
        self.date = .now
    }
    
    func toGIfData() throws -> GifData {
        try GifData(imageId: imageId ?? .init(),
                url: URL(string: url ?? ""),
                isFavorite: isFavourite)
    }
}
