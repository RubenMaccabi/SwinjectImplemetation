//
//  ContentView.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 19/03/2024.
//

import SwiftUI
import CoreData
import DIWrapper

struct ContentView: View {
    
    @EnvironmentObject private var delegate: AppDelegate

    var body: some View {
        delegate.start()
            .ignoresSafeArea()
            .preferredColorScheme(.dark)
    }
}

#Preview {
    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate
    return ContentView()
        .environmentObject(appDelegate)
}
