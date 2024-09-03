//
//  MonkeyGifApp.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 19/03/2024.
//

import SwiftUI
import DIWrapper

let runSwiftUI = true

struct MonkeyGifApp: App {
    
    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appDelegate)
        }
    }
}

@UIApplicationMain
class AppDelegate: NSObject, UIApplicationDelegate, UISceneDelegate, ObservableObject, UIEntryPoint {
    
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
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfiguration = UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        sceneConfiguration.delegateClass = AppDelegate.self
        return sceneConfiguration
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        if runSwiftUI {
            let view = ContentView().environmentObject(self)
            self.rootViewController = UIHostingController(rootView: view)
        } else {
            self.assembledApp?.startUIKitApp()
        }
    }
    
    func start() -> some View {
        guard let assembledApp else {
            fatalError("App not built !")
        }
        return assembledApp.startSwiftUiApp()
    }
}
