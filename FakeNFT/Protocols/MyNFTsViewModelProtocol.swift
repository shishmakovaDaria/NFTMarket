//
//  MyNFTsViewModelProtocol.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 17.10.2023.
//

import Foundation

protocol MyNFTsViewModelProtocol: Sortable {
    var nfts: [NFTModel] { get }
    var nftsObservable: Observable<[NFTModel]> { get }
    var likes: [String] { get }
    var likesObservable: Observable<[String]> { get }
    var nftsAuthors: [UserModel] { get }
    var nftsAuthorsObservable: Observable<[UserModel]> { get }
    var isLoading: Bool { get }
    var isLoadingObservable: Observable<Bool> { get }
    
    func setValues(myNFTS: [String], myLikedNFTs: [String])
    func updateNFTs()
    func handleLikeButtonTapped(nftIndex: Int)
    func configureCellModel(nftIndex: Int) -> MyNFTsCellModel
}
