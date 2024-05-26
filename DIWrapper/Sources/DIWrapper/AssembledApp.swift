//
//  File.swift
//  
//
//  Created by Ruben  on 19/05/2024.
//

import Foundation
import SwiftUI


/// AssemblyApp: Entry point of the Di flow
public class AssembledApp: ObservableObject {
    
    private var diBuilder: DiBuilder
    private let uiEntryPoint: UIEntryPoint
    
    public var window: UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = UIColor.red
        return window
    }
    
    /// Initializer of the EntryPoint of the Di Flow
    /// - Parameters:
    ///   - uiEntryPoint: Implements UIEntryPoint protocol, recommended to be the AppDelegate
    ///   - di: DI instance, from which you called makeAssembler()
    public init(uiEntryPoint: UIEntryPoint, di: DiBuilder) {
        self.uiEntryPoint = uiEntryPoint
        self.diBuilder = di
        self.uiEntryPoint.window = window
        self.diBuilder.build()
    }
    
    /// Creates SwiftUI Root View, in which all the dependencies are injected
    /// - Returns: App Root View
    public func startSwiftUiApp() -> some View {
        AnyView(diBuilder.startSwiftUIApp())
            .environment(\.assembledApp, self)
    }
    
    /// Sets the root view controller of an UIKit App
    public func startUIKitApp() {
        self.uiEntryPoint.rootViewController = diBuilder.startUIKitApp()
    }
}
