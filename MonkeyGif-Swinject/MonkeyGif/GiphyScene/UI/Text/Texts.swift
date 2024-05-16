//
//  Texts.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 22/03/2024.
//

import Foundation

enum Texts {
    enum Search {
        static let global = "Find your dream gif !"
        static let bydId = "Insert a gif id only"
    }
    enum EmptySearch {
        static let all = "No gifs found ! \n Tap and pull to refresh"
        static let favorites = "No gifs saved yet !"
        static let idle = "Loading Gifs"
    }
    
    enum Alert {
        static let action = "Such a shame"
        
        enum Title {
            static let title_decoding = "Oops Bad decoding !"
            static let title_url = "Oops Could not execute !"
            static let title_coredata = "Oops Internal persistence !"
            static let title_httpError = "Oops Request failed !"
        }
        
        enum Message {
            static let message_decoding = "The dev didn't parse to proper DTOs. "
            static let message_url = "URL is malformed, the dev must be tired."
            static let message_coredata = "Hope for you it will work later."
            static let message_httpError = "The server is failing us!"
        }
    }
    
    enum Collection {
        enum Context {
            static let title = "Selected item"
            static let addToFavoriteAction = "Add to favorite"
        }
    }
}
