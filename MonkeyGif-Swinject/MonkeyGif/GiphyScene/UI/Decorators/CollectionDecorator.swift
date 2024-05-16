//
//  UIKit.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 20/03/2024.
//

import Foundation
import UIKit
import CoreData

@objc protocol CollectionRequestProtocol {
    var collectionView: UICollectionView! { get}
    var switchAction: UIAction { get }
    func request()
    func showFavorites()
}

protocol CollectionMenuInteractionProtocol {
    func save(gif: GifData)
}


class CollectionDecorator: NSObject, DecoratorProtocol {
    
    typealias Holder = (CollectionRequestProtocol & CollectionMenuInteractionProtocol & UIViewController)?
    
    weak var holder: Holder
    private var data: [GifData]
    private lazy var refreshControl: UIRefreshControl = {
        var rc = UIRefreshControl()
        if let holder = holder {
            rc.addTarget(holder, action: #selector(holder.request), for: .valueChanged)
        }
        return rc
    }()
    
    private var collectionView: UICollectionView? {
        holder?.collectionView
    }
    
    init(holder: Holder) {
        self.holder = holder
        self.data = [.init()]
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        setupNavigationBar()
        collectionView?.setupCollectionView(cell: CellContainer<GifViewCell>(), CellContainer<EmptyContentCell>(), dataSource: self, delegate: self)
        collectionView?.refreshControl = refreshControl
    }

    func update(data: [GifData]) {
        self.data = .init(data)
        self.collectionView?.updateLayout(data.isEmpty ? .oneCellLayout : .multipleItemLayout)
        self.collectionView?.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func makeSwitch() -> UISwitch {
        let toggle = UISwitch()
        if let holder = holder {
            toggle.addAction(holder.switchAction, for: .valueChanged)
        }
        return toggle
    }
    
    private func setupNavigationBar() {
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().backgroundColor = .black
        guard let holder = holder else { return }
        holder.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .init(sf: .star), style: .plain, target: holder, action: #selector(holder.showFavorites))
        holder.navigationItem.leftBarButtonItem = .init(customView: makeSwitch())
    }
    
    private func contextMenu(gifData: GifData) -> UIMenu {
        let favorite = UIAction(title: Texts.Collection.Context.addToFavoriteAction, image: UIImage(sf: .star)) {[weak self] action in
            self?.holder?.save(gif: gifData)
        }
        return UIMenu(title: Texts.Collection.Context.title, children: [favorite])
    }
}


extension CollectionDecorator: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.populateGifCell(with: data, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        if let first = data.first, first.isEmpty {
            return nil
        } else if let firstIndex =  indexPaths.first {
            return UIContextMenuConfiguration(actionProvider:  {[weak self] suggestedActions in
                self?.contextMenu(gifData: self!.data[firstIndex.item])
            })
        } else {
            return nil
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if data.count > 49, indexPath.item == data.count - 1  {
            holder?.request()
        }
    }
}
