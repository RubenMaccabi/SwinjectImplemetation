//
//  EmptyContentCell.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 02/04/2024.
//

import UIKit

class EmptyContentCell: UICollectionViewCell {
    
    enum EmptyType {
        case all, favorite, idle
        
        var label: String {
            switch self {
            case .all:
                Texts.EmptySearch.all
            case .favorite:
                Texts.EmptySearch.favorites
            case .idle:
                Texts.EmptySearch.idle
            }
        }
        
        var image: UIImage {
            switch self {
            case .all:
                    .init(sf: .camera)
            case .favorite:
                    .init(sf: .star)
            case .idle:
                    .init(sf: .loading)
            }
        }
    }
    
    private var emptyType: EmptyType = .idle {
        didSet {
            self.imageView.image = emptyType.image
            self.labelView.text = emptyType.label
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        emptyType = .idle
    }
    
    func show(for type: EmptyType) {
        emptyType = type
        transform = .init(scaleX: .zero, y: .zero)
        UIView.animateBouncy(withDuration: 0.3) {[weak self] in
            self?.transform = .identity
        }
    }

}
