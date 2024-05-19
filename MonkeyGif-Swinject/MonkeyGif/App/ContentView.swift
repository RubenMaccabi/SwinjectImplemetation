//
//  ContentView.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 19/03/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
        @Environment(AssembleWrapper.self) var assemble
    
    var body: some View {
        assemble.startApp()
            .ignoresSafeArea()
            .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
