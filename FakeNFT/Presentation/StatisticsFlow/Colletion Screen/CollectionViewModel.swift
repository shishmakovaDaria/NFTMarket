//
//  CollectionViewModel.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 08.08.2023.
//

import Foundation

final class CollectionViewModel {
    // MARK: - Observables
    @Observable
    private (set) var nfts: [NFTModel] = []
    
    //MARK: - Properties:
    
    private let nftCollection: [String]
    
    //MARK: - Servicies
    let nftService = NFTService()
    
    //MARK: - LifeCycle
    
    init(nfts: [String]) {
        self.nftCollection = nfts
        self.getNFTModel()
    }
    
    //MARK: - Methods
    
    private func getNFTModel() {
        nftCollection.forEach { nftID in
            nftService.getNFT(with: nftID) { result in
                switch result {
                case .success(let nft):
                    self.nfts.append(nft)
                case .failure(let error):
                    print("Ошибка получения NFT: \(error)")
                }
            }
        }
    }
}
