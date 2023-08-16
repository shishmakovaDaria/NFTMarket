//
//  FavoriteNFTsViewModel.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 16.08.2023.
//

import Foundation

protocol FavoriteNFTsViewModelProtocol {
    var nfts: [NFTModel] { get }
    var nftsObservable: Observable<[NFTModel]> { get }
    var likes: [String] { get }
    var likesObservable: Observable<[String]> { get }
    var isLoading: Bool { get }
    var isLoadingObservable: Observable<Bool> { get }
    
    func setValues(favoriteNFTS: [String])
    func updateNFTs()
    func handleLikeButtonTapped(nftIndex: Int)
    //TODO: - protocol
}

final class FavoriteNFTsViewModel: FavoriteNFTsViewModelProtocol {
    
    @Observable
    private(set) var nfts: [NFTModel] = []
    
    @Observable
    private(set) var likes: [String] = []
    
    @Observable
    private(set) var isLoading: Bool = false
    
    var nftsObservable: Observable<[NFTModel]> { $nfts }
    var likesObservable: Observable<[String]> { $likes }
    var isLoadingObservable: Observable<Bool> { $isLoading }
    
    private var nftIDs: [String] = []
    private let nftService: NFTServiceProtocol
    private let profileService: ProfileServiceProtocol
    
    init(
        nftService: NFTServiceProtocol = NFTService(),
        profileService: ProfileServiceProtocol = ProfileService()
    ) {
        self.nftService = nftService
        self.profileService = profileService
    }
    
    func setValues(favoriteNFTS: [String]) {
        nftIDs = favoriteNFTS
        likes = favoriteNFTS
    }
    
    func updateNFTs() {
        if nftIDs.isEmpty == false {
            isLoading = true
            nftIDs.forEach { nftID in
                nftService.getNFT(with: nftID) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let nft):
                        self.nfts.append(nft)
                    case .failure(let error):
                        print("Ошибка получения NFT: \(error)")
                    }
                    if nfts.count == nftIDs.count {
                        isLoading = false
                    }
                }
            }
        }
    }
    
    func handleLikeButtonTapped(nftIndex: Int) {
        isLoading = true
        let nft = nfts[nftIndex]
        profileService.changeNFTLike(like: nft.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let profile):
                likes = profile.likes
            case .failure(let error):
                print("Ошибка отправки лайка: \(error)")
            }
            isLoading = false
        }
    }
    
    //TODO: - cell
    /*func configureCellModel(nftIndex: Int) -> MyNFTsCellModel {
        let nft = nfts[nftIndex]
        
        return MyNFTsCellModel(
            name: nft.name,
            image: nft.images.first ?? "",
            rating: nft.rating,
            author: "From".localized().lowercased() + " \(author)",
            price: "\(nft.price) ETH",
            isLiked: likes.contains(nft.id)
        )
    }*/
}
