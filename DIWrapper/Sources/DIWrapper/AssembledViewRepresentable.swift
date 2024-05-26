//
//  File.swift
//  
//
//  Created by Ruben  on 19/05/2024.
//

import Foundation
import SwiftUI


/// In order to have a shared view between UIKit and swiftUI we wrap the UIViewController, in a UIViewController.
struct AssembledViewRepresentable: UIViewControllerRepresentable {
    
    let parent: DiBuilder
            
    func makeUIViewController(context: Context) -> UIViewController {
        guard let startApp = parent.startUIKitApp() else {
           fatalError("DiBuilder does not implement StartAppProtocol")
        }
        return startApp
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}
