//
//  Extension+UIViewController.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 22/03/2024.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(_ model: AppErrorModel) {
       let alertVC = UIAlertController(title: model.title, message: model.message, preferredStyle: .alert)
       alertVC.addAction(.init(title: Texts.Alert.action, style: .cancel))
       present(alertVC, animated: true)
   }
}
