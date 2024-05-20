//
//  FavoriteViewController.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 20/03/2024.
//

import UIKit
import Combine

final class FavoriteViewController: UIViewController, ViewControllerProtocol, CollectionFavoriteProtocol {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var subscriptions: Set<AnyCancellable> = .init()
    
    let coordinator: FavoriteViewControllerCoordinator
    let viewModel: FavoriteViewControllerViewModel

    lazy var favoriteDecorator: FavoriteDecoratorProtocol = {
        FavoriteDecoratorProtocol(holder: self)
    }()
    
    init(viewModel: FavoriteViewControllerViewModel, coordinator: FavoriteViewControllerCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        self.subscriptions = .init()
        super.init(nibName: String(describing: Self.self), bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func build(coordinator: FavoriteViewControllerCoordinator, viewModel: FavoriteViewControllerViewModel) -> FavoriteViewController {
        FavoriteViewController(viewModel: viewModel, coordinator: coordinator)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        observeDataChanges()
    }
    
    func setupUI() {
        favoriteDecorator.setup()
    }
    
    func observeDataChanges() {
        viewModel.$fetchState
            .receive(on: DispatchQueue.main)
            .sink {[weak self] state in
                switch state {
                case .idle:
                    break
                case .fetched(let data):
                    self?.favoriteDecorator.update(isEmpty: data.0, data: data.1)
                case .failure(let error):
                    self?.showAlert(.init(error: error))
                }
            }
            .store(in: &subscriptions)
    }
    
    @objc func backButtonAction() {
        coordinator.dismiss()
    }
    
    deinit {
        subscriptions.forEach { $0.cancel() }
    }
}
