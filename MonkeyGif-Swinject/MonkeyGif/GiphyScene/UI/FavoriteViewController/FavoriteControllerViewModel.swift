//
//  FavoriteControllerViewModel.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 21/03/2024.
//

import Foundation
import CoreData
import UIKit

class FavoriteViewControllerViewModel: NSObject, NSFetchedResultsControllerDelegate, FetchingViewModelProtocol {
    
    private let viewContext: NSManagedObjectContext
    private var fetchedResultsController: NSFetchedResultsController<MGGif>?
    @Published var fetchState: FetchState<(Bool, NSDiffableDataSourceSnapshot<Int, MGGif>)>
    
    init(fetchedResultsController: NSFetchedResultsController<MGGif>? = nil, viewContext: NSManagedObjectContext) {
        self.fetchedResultsController = fetchedResultsController
        self.fetchState = .idle
        self.viewContext = viewContext
        super.init()
        loadSavedData()
    }
    
    private func loadSavedData() {
        if fetchedResultsController == nil {
            let request = MGGif.fetchRequest()
            request.fetchBatchSize = 3
            request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
            fetchedResultsController = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: viewContext,
                sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController?.delegate = self
        }
        do {
            try fetchedResultsController?.performFetch()
            updateSnapshot()
        } catch {
            fetchState = .failure(.coreData(description: error.localizedDescription))
        }
    }
    
    private func updateSnapshot() {
        var diffableDataSourceSnapshot = NSDiffableDataSourceSnapshot<Int, MGGif>()
        diffableDataSourceSnapshot.appendSections([0])
        let objects = fetchedResultsController?.fetchedObjects ?? []
        let items = objects.isEmpty ? [MGGif(context: viewContext)] : objects
        let isEmpty = objects.first?.imageId == nil
        diffableDataSourceSnapshot.appendItems(items)
        fetchState = .fetched((isEmpty, diffableDataSourceSnapshot))
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        updateSnapshot()
    }
    
    deinit {
        viewContext.rollback()
    }
}
