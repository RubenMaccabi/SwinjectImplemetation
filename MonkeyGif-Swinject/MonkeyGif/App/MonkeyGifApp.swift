//
//  MonkeyGifApp.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 19/03/2024.
//

import SwiftUI

@main
struct MonkeyGifApp: App {
    
    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
           ContentView()
                .environment(appDelegate.assemblerWrapper)
        }
    }
}

@Observable
class AppDelegate: NSObject, UIApplicationDelegate, UIEntryPoint {
    
    var assemblerWrapper: AssembleWrapper?
    var window: UIWindow?    
    
    var rootViewController: UIViewController? {
        get { nil }
        set {
            self.window?.rootViewController = newValue
            self.window?.makeKeyAndVisible()
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        assemblerWrapper = .init(uiEntryPoint: self)
        return true
    }
}
