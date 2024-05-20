//
//  AppViewController.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 19/03/2024.
//

import UIKit
import Combine

final class AppViewController: UIViewController, UISearchResultsUpdating, ViewControllerProtocol, CollectionRequestProtocol {

    typealias Coordinator = AppViewControllerCoordinator
    typealias ViewModel = AppViewControllerViewModel
                
    @IBOutlet var collectionView: UICollectionView!
    private var subscriptions: Set<AnyCancellable>
    
    var coordinator: AppViewControllerCoordinator
    var viewModel: AppViewControllerViewModel

    lazy var collectionDecorator: CollectionDecorator = {
        CollectionDecorator(holder: self)
    }()
    
    lazy var searchDisplayDecorator: SearchControllerDecorator = {
        SearchControllerDecorator(controller: self)
    }()
    
    var switchAction: UIAction {
        UIAction {[weak self] _ in
            self?.viewModel.toggleSearchState()
        }
    }
    
    init(viewModel: ViewModel, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        self.subscriptions = .init()
        super.init(nibName: String(describing: Self.self), bundle: .main
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        observeDataChanges()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.updateTrendingScroll()
    }
    
    static func build(coordinator: AppViewControllerCoordinator, viewModel: AppViewControllerViewModel) -> AppViewController {
        AppViewController.init(viewModel: viewModel, coordinator: coordinator)
    }

    func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchText = searchController.searchBar.text
    }

    func setupUI() {
        collectionDecorator.setup()
        searchDisplayDecorator.setup()
    }
    
    func observeDataChanges() {
        viewModel.$fetchState
            .receive(on: DispatchQueue.main)
            .sink {[weak self] state in
                switch state {
                case .fetched(let gifs):
                    self?.collectionDecorator.update(data: gifs)
                case .failure(let appError):
                    self?.showAlert(.init(error: appError))
                default:
                    break
                }
            }
            .store(in: &subscriptions)
        
        viewModel.$searchState
            .receive(on: DispatchQueue.main)
            .sink {[weak self] state in
                self?.searchDisplayDecorator.update(searchState: state)
            }
            .store(in: &subscriptions)
    }
    
    @objc func showFavorites() {
        coordinator.showFavorites()
    }
    
    @objc func request() {
        viewModel.updateTrendingScroll()
    }
    
    deinit {
        subscriptions.forEach { $0.cancel() }
    }
}


extension AppViewController: CollectionMenuInteractionProtocol {
    func save(gif: GifData) {
        viewModel.addToFavorite(gif)
    }
}
