//
//  File.swift
//  
//
//  Created by Ruben  on 19/05/2024.
//

import Foundation
import UIKit

public protocol UIEntryPoint: AnyObject {
    var window: UIWindow? { get set }
    var rootViewController: UIViewController? { get set }
}
