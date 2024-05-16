//
//  MonkeyGifApp.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 19/03/2024.
//

import SwiftUI

@main
struct MonkeyGifApp: App {
    
    let apiKey: String
    let persistenceController = PersistenceController.shared
    
    init() {
        let reader = PlistReader(keyList: .appKeys)
        let appKeys: AppKeys = reader.read()
        self.apiKey = appKeys.giphyApi
    }

    var body: some Scene {
        WindowGroup {
            ContentView(apiKey: apiKey)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
