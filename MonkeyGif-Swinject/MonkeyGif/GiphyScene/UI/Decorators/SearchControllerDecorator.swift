//
//  SearchControllerDecorator.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 20/03/2024.
//

import Foundation
import UIKit

enum SearchState {
    case global, byId
    
    var title: String {
        switch self {
        case .global:
            return Texts.Search.global
        case .byId:
            return Texts.Search.bydId
        }
    }
}

class SearchControllerDecorator:NSObject, DecoratorProtocol {
    
    typealias Holder = (UIViewController & UISearchResultsUpdating)?
    
    weak var holder: Holder
    
    private var searchBar: UISearchController = {
        let sb = UISearchController()
        sb.searchBar.placeholder = SearchState.global.title
        sb.searchBar.searchBarStyle = .minimal
        return sb
    }()
    
    init(controller: Holder) {
        holder = controller
        super.init()
    }
    
    func setup() {
        searchBar.obscuresBackgroundDuringPresentation = true
        searchBar.searchResultsUpdater = holder
        holder?.navigationItem.searchController = searchBar
        holder?.definesPresentationContext = true
    }
    
    func update(searchState: SearchState) {
        searchBar.searchBar.placeholder = searchState.title
    }
}

