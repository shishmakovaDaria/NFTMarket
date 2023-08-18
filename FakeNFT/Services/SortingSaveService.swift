//
//  SortingSaveService.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 17.08.2023.
//

import Foundation

final class SortingSaveService: SortingSaveServiceProtocol {
    
    private var screen: SortForScreen
    
    init(screen: SortForScreen) {
        self.screen = screen
    }
    
    var savedSorting: Sort {
        var sorting = Sort.name
        
        if sortConfig == "price" { sorting = .price }
        if sortConfig == "rating" { sorting = .rating }
        if sortConfig == "NFTName" { sorting = .NFTName }
        if sortConfig == "NFTCount" { sorting = .NFTCount }
        if sortConfig == "name" { sorting = .name }
        
        if sortConfig == nil {
            switch screen {
            case .catalogue:
                sorting = .NFTCount
            case .profile:
                sorting = .rating
            case .cart:
                sorting = .name
            case .statistic:
                sorting = .rating
            }
        }
        return sorting
    }
    
    private let userDefaults = UserDefaults.standard
    
    private enum Keys: String {
        case sortConfigCatalogue, sortConfigProfile, sortConfigCart, sortConfigStatistic
    }
    
    private var sortConfig: String? {
        switch screen {
        case .catalogue:
            return userDefaults.string(forKey: Keys.sortConfigCatalogue.rawValue)
        case .profile:
            return userDefaults.string(forKey: Keys.sortConfigProfile.rawValue)
        case .cart:
            return userDefaults.string(forKey: Keys.sortConfigCart.rawValue)
        case .statistic:
            return userDefaults.string(forKey: Keys.sortConfigStatistic.rawValue)
        }
    }
    
    func saveSorting(param: Sort) {
        switch screen {
        case .catalogue:
            saveSortingForScreen(param: param, key: Keys.sortConfigCatalogue.rawValue)
        case .profile:
            saveSortingForScreen(param: param, key: Keys.sortConfigProfile.rawValue)
        case .cart:
            saveSortingForScreen(param: param, key: Keys.sortConfigCart.rawValue)
        case .statistic:
            saveSortingForScreen(param: param, key: Keys.sortConfigStatistic.rawValue)
        }
    }
    
    private func saveSortingForScreen(param: Sort, key: String) {
        switch param {
        case .price:
            userDefaults.set("price", forKey: key)
        case .rating:
            userDefaults.set("rating", forKey: key)
        case .name:
            userDefaults.set("name", forKey: key)
        case .NFTCount:
            userDefaults.set("NFTCount", forKey: key)
        case .NFTName:
            userDefaults.set("NFTName", forKey: key)
        }
    }
}
