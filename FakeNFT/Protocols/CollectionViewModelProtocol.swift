//
//  CollectionViewModelProtocol.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 17.08.2023.
//

import Foundation

protocol CollectionViewModelProtocol {
    var nfts: [NFTModel] { get }
    var nftsObservable: Observable<[NFTModel]> { get }
    var likes: [String] { get }
    var likesObservable: Observable<[String]> { get }
    var cartNFTs: [String] { get }
    var cartNFTsObservable: Observable<[String]> { get }
    var isLoading: Bool { get }
    var isLoadingObservable: Observable<Bool> { get }
    var nftService: NFTServiceProtocol { get }
    var profileService: ProfileServiceProtocol { get }
    var  cartService: CartServiceProtocol { get }
    init(nfts: [String],
         nftService: NFTServiceProtocol,
         profileService: ProfileServiceProtocol,
         cartService: CartServiceProtocol)
    func likeButtonTapped(at indexPath: IndexPath)
    func cartButtonTapped(at indexPath: IndexPath)
    func getCellModel(at indexPath: IndexPath) ->  NFTCollectionCellModel
}
