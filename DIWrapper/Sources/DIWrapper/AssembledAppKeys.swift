//
//  File.swift
//  
//
//  Created by Ruben  on 19/05/2024.
//

import Foundation
import SwiftUI


struct AssembledAppKey: EnvironmentKey {
    static var defaultValue: AssembledApp?
}

public extension EnvironmentValues {
    
    /// Access to the root of the DI
     var assembledApp: AssembledApp? {
        get { self[AssembledAppKey.self] }
        set { self[AssembledAppKey.self] = newValue }
    }
}

