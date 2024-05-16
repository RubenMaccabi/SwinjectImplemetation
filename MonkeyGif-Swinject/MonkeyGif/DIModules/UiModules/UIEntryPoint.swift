//
//  UIEntryPoint.swift
//  MonkeyGif
//
//  Created by Ruben  on 16/05/2024.
//

import Foundation
import UIKit

protocol UIEntryPoint: AnyObject {
    var window: UIWindow? { get set }
    var rootViewController: UIViewController? { get set }
}
