//
//  GifViewCell.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 20/03/2024.
//

import UIKit
import Combine
import SwiftyGif

class GifViewCell: UICollectionViewCell {
        
    @IBOutlet weak private (set) var gifImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.gifImageView.delegate = self
    }
    
    func setup(gifData : GifData) {
        let loader = UIActivityIndicatorView()
        loader.style = .medium
        self.gifImageView.setGifFromURL(gifData.url, customLoader: loader)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.gifImageView.image = nil
    }
}

extension GifViewCell: SwiftyGifDelegate {
    
    func gifURLDidFinish(sender: UIImageView) {
        UIView.animateBouncy(withDuration: 0.3) {
            sender.layer.borderWidth = 1
            sender.layer.borderColor = UIColor.white.cgColor
            sender.layer.cornerRadius = 8
            sender.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        } completion: { _ in
            UIView.animateBouncy(withDuration: 0.5) {
                sender.transform = .identity
            }
        }
    }
}
