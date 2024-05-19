//
//  FavoriteDecoratorProtocol.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 21/03/2024.
//

import Foundation
import UIKit

@objc protocol CollectionFavoriteProtocol {
    var collectionView: UICollectionView! { get}
    func backButtonAction()
}

class FavoriteDecoratorProtocol: NSObject, DecoratorProtocol {
    
    typealias Holder = (UIViewController & CollectionFavoriteProtocol)?
    
    weak var holder: Holder
    private var diffableDataSource: UICollectionViewDiffableDataSource<Int, MGGif>?
    
    private var collectionView: UICollectionView? {
        holder?.collectionView
    }
    
    init(holder: Holder) {
        self.holder = holder
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        guard let collectionView else { return }
        diffableDataSource = UICollectionViewDiffableDataSource<Int, MGGif>(collectionView: collectionView) { (view, indexPath, item) -> UICollectionViewCell? in
            view.populateGifCellDiffable(item: item, indexPath: indexPath)
        }
        collectionView.setupCollectionView(cell: CellContainer<GifViewCell>(), CellContainer<EmptyContentCell>(), dataSource: diffableDataSource, delegate: nil)
        setupNavigationBar()
    }
    
    func update(isEmpty: Bool, data: NSDiffableDataSourceSnapshot<Int, MGGif>) {
        if isEmpty {
            collectionView?.updateLayout(.oneCellLayout)
        } else {
            collectionView?.updateLayout(.threeLineLayout)
        }
        diffableDataSource?.apply(data, animatingDifferences: true)
        collectionView?.reloadData()
    }
    
    private func setupNavigationBar() {
        guard let holder  else { return }
        holder.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        holder.navigationItem.title = "Favorites ❤️"
        holder.navigationItem.titleView?.tintColor = .red
        holder.navigationItem.leftBarButtonItem = .init(image: .init(sf: .chevronLeft), style: .plain, target: holder, action: #selector(holder.backButtonAction))
    }
}
