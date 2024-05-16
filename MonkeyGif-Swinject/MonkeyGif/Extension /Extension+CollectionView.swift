//
//  Extension+CollectionView.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 20/03/2024.
//

import Foundation
import UIKit


extension UICollectionView {
    
    struct CellContainer<Cell: UICollectionViewCell> {
        let cellType: Cell.Type
        init() {
            cellType = Cell.self
        }
        
        func register(in collectionView: UICollectionView) {
            collectionView.register(Cell.toNib(), forCellWithReuseIdentifier: Cell.identifier)
        }
    }
    
    func setupCollectionView<each Cell>(
        cell: repeat CellContainer<each Cell>,
        dataSource: UICollectionViewDataSource?,
        delegate: UICollectionViewDelegate?) {
            repeat (each cell).register(in: self)
            self.dataSource = dataSource
            self.delegate = delegate
            updateLayout(.oneCellLayout)
        }
    
    func updateLayout(_ layout: UICollectionViewCompositionalLayout) {
        collectionViewLayout = layout
    }
    
    func dequeue<Cell: UICollectionViewCell>(indexPath: IndexPath) -> Cell {
        dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as! Cell
    }
    
    func populateGifCell(with data: [GifData], for indexPath: IndexPath) -> UICollectionViewCell {
        if let first = data.first, first.isEmpty {
            let cell: EmptyContentCell = dequeue(indexPath: indexPath)
            cell.show(for: .all)
            return cell
        } else {
            let cell: GifViewCell = dequeue(indexPath: indexPath)
            cell.setup(gifData: data[indexPath.item])
            return cell
        }
    }
    
    func populateGifCellDiffable(item: MGGif, indexPath: IndexPath) -> UICollectionViewCell? {
        if item.imageId == nil {
            let cell: EmptyContentCell = dequeue(indexPath: indexPath)
            cell.show(for: .favorite)
            return cell
        } else {
            let cell: GifViewCell = dequeue(indexPath: indexPath)
            do {
                let data = try item.toGIfData()
                cell.setup(gifData: data)
            } catch {
                print(#function, error.localizedDescription, "cannot display a cell with no url")
                return nil
            }
            return cell
        }
    }
}


