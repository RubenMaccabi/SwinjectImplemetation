//
//  MonkeyGifApp.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 19/03/2024.
//

import SwiftUI
import DIWrapper

@main
struct MonkeyGifApp: App {
    
    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
           ContentView()
            .environmentObject(appDelegate)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject, UIEntryPoint {
    
    var assembledApp: AssembledApp!
    var window: UIWindow?
    
    var rootViewController: UIViewController? {
        didSet {
            window?.rootViewController = rootViewController
            window?.makeKeyAndVisible()
        }
    }
    
    override init() {
        super.init()
        self.assembledApp = .init(uiEntryPoint: self, di: buildDI())
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
       // self.assembledApp?.startUIKitApp()
        return true
    }
    
    func start() -> some View {
        guard let assembledApp else {
            fatalError("App not built !")
        }
       return assembledApp.startSwiftUiApp()
    }
}
