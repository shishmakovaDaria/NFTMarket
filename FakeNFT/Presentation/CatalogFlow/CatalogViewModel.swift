//
//  CatalogViewModel.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 02.08.2023.
//

import Foundation

final class CatalogViewModel: CatalogViewModelProtocol {
    
    //MARK: - Observables
    @Observable
    private(set) var collections: [CollectionModel] = []
    
    @Observable
    private(set) var isLoading: Bool = false
    
    //MARK: - Properties
    var collectionsObservable: Observable<[CollectionModel]> { $collections }
    var isLoadingObservable: Observable<Bool> { $isLoading }
    
    private let collectionsService: CollectionsServiceProtocol
    private let sortingSaveService: SortingSaveServiceProtocol
    
    //MARK: - LifeCycle
    init(
        collectionsService: CollectionsServiceProtocol = CollectionsService(),
        sortingSaveService: SortingSaveServiceProtocol = SortingSaveService(screen: .catalog)
    ) {
        self.collectionsService = collectionsService
        self.sortingSaveService = sortingSaveService
    }
    
    //MARK: - Methods
    func updateCollections() {
        isLoading = true
        collectionsService.getCollections { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let body):
                self.collections = body
                self.sort(param: sortingSaveService.savedSorting)
            case .failure(let error):
                print("Ошибка получения коллекций: \(error)")
            }
            self.isLoading = false
        }
    }
    
    func configureCellModel(nftIndex: Int) -> CatalogCellModel {
        let collection = collections[nftIndex]
        
        return CatalogCellModel(
            name: "\(collection.name) (\(collection.nfts.count))",
            image: collection.cover
        )
    }
}

//MARK: - UITableViewDelegate
extension CatalogViewModel: Sortable {
    func sort(param: Sort) {
        sortingSaveService.saveSorting(param: param)
        switch param {
        case .price:
            break
        case .rating:
            break
        case .name:
            break
        case .NFTCount:
            collections = collections.sorted(by: { $0.nfts.count > $1.nfts.count })
        case .NFTName:
            collections = collections.sorted(by: { $0.name < $1.name })
        }
    }
}
