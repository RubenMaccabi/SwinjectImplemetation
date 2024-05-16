//
//  AppErrorModel.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 21/03/2024.
//

import Foundation

struct AppErrorModel {
    
    let error: AppError
    
    var title: String {
        switch error {
        case .decoding:
            Texts.Alert.Title.title_decoding
        case .url:
            Texts.Alert.Title.title_url
        case .coreData:
            Texts.Alert.Title.title_coredata
        case .httpError:
            Texts.Alert.Title.title_httpError
        }
    }
    
    var message: String {
        switch error {
        case .decoding:
            Texts.Alert.Message.message_decoding
        case .url:
            Texts.Alert.Message.message_url
        case .coreData:
            Texts.Alert.Message.message_coredata
        case .httpError:
            Texts.Alert.Message.message_httpError
        }
    }
    
}
