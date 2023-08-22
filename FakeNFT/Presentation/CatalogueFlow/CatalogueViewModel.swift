//
//  CatalogueViewModel.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 02.08.2023.
//

import Foundation

protocol CatalogueViewModelProtocol: Sortable {
    var collections: [CollectionModel] { get }
    var collectionsObservable: Observable<[CollectionModel]> { get }
    var isLoading: Bool { get }
    var isLoadingObservable: Observable<Bool> { get }
    
    func updateCollections()
    func configureCellModel(nftIndex: Int) -> CatalogCellModel
}

final class CatalogueViewModel: CatalogueViewModelProtocol {
    
    @Observable
    private(set) var collections: [CollectionModel] = []
    
    @Observable
    private(set) var isLoading: Bool = false
    
    var collectionsObservable: Observable<[CollectionModel]> { $collections }
    var isLoadingObservable: Observable<Bool> { $isLoading }
    
    func updateCollections() {
        //потом заменить
        collections = [
            CollectionModel(
                createdAt: "",
                name: "Peach",
                cover: "https://upload.wikimedia.org/wikipedia/commons/e/e6/Ryan_Gosling_by_Gage_Skidmore.jpg",
                nfts: ["1", "2", "3"],
                description: "",
                author: "",
                id: "1"),
            CollectionModel(
                createdAt: "",
                name: "Blue",
                cover: "https://upload.wikimedia.org/wikipedia/commons/e/e6/Ryan_Gosling_by_Gage_Skidmore.jpg",
                nfts: ["5", "6"],
                description: "",
                author: "",
                id: "2"
            )
                       
        ]
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
extension CatalogueViewModel: Sortable {
    func sort(param: Sort) {
        //TODO: -
    }
}
