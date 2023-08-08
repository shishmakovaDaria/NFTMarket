//
//  MyNFTsViewModel.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 08.08.2023.
//

import Foundation

final class MyNFTsViewModel {
    
    @Observable
    private(set) var NFTs: [NFTModel] = []
    
    private let nftService = NFTService()
    var nftIDs: [String] = []
    
    func updateNFTs() {
        var newNfts: [NFTModel] = []
        nftIDs.forEach { nftID in
            nftService.getNFT(with: nftID) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let nft):
                    newNfts.append(nft)
                case .failure(let error):
                    print("Ошибка получения NFT: \(error)")
                }
                self.NFTs = newNfts
            }
        }
    }
}
