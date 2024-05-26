//
//  AppKeysAssembly.swift
//  MonkeyGif
//
//  Created by Ruben  on 16/05/2024.
//

import DIWrapper

let appkeysContainer = AssemblyContainer(scope: .container) { _ in
    let reader = PlistReader(keyList: .appKeys)
    let appKeys: AppKeys = reader.read()
    return appKeys
}
