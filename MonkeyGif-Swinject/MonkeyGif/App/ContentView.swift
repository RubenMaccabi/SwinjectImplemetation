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
        AppRepresentable(assemble:  assemble)
            .ignoresSafeArea()
            .preferredColorScheme(.dark)
    }
}

struct AppRepresentable: UIViewControllerRepresentable {
    
    let assemble: AssembleWrapper
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return assemble.startApp()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

#Preview {
    ContentView()
}
