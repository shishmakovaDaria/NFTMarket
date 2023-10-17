//
//  CatalogViewModelProtocol.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 17.10.2023.
//

import Foundation

protocol CatalogViewModelProtocol: Sortable {
    var collections: [CollectionModel] { get }
    var collectionsObservable: Observable<[CollectionModel]> { get }
    var isLoading: Bool { get }
    var isLoadingObservable: Observable<Bool> { get }
    
    func updateCollections()
    func configureCellModel(nftIndex: Int) -> CatalogCellModel
}
