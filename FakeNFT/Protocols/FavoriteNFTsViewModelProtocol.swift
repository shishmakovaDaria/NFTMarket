//
//  FavoriteNFTsViewModelProtocol.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 17.10.2023.
//

import Foundation

protocol FavoriteNFTsViewModelProtocol {
    var nfts: [NFTModel] { get }
    var nftsObservable: Observable<[NFTModel]> { get }
    var isLoading: Bool { get }
    var isLoadingObservable: Observable<Bool> { get }
    
    func setValue(favoriteNFTS: [String])
    func updateNFTs()
    func handleLikeButtonTapped(nftIndex: Int)
    func configureCellModel(nftIndex: Int) -> FavoriteNFTsCellModel
}
