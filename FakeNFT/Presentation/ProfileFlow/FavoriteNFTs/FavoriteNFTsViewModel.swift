//
//  FavoriteNFTsViewModel.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 16.08.2023.
//

import Foundation

final class FavoriteNFTsViewModel: FavoriteNFTsViewModelProtocol {
    
    //MARK: - Observables
    @Observable
    private(set) var nfts: [NFTModel] = []
    
    @Observable
    private(set) var isLoading: Bool = false
    
    //MARK: - Properties
    var nftsObservable: Observable<[NFTModel]> { $nfts }
    var isLoadingObservable: Observable<Bool> { $isLoading }
    
    private var nftIDs: [String] = []
    private let nftService: NFTServiceProtocol
    private let profileService: ProfileServiceProtocol
    
    //MARK: - LifeCycle
    init(
        nftService: NFTServiceProtocol = NFTService(),
        profileService: ProfileServiceProtocol = ProfileService()
    ) {
        self.nftService = nftService
        self.profileService = profileService
    }
    
    //MARK: - Methods
    func setValue(favoriteNFTS: [String]) {
        nftIDs = favoriteNFTS
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
                    if self.nfts.count == self.nftIDs.count {
                        self.isLoading = false
                    }
                }
            }
        }
    }
    
    func handleLikeButtonTapped(nftIndex: Int) {
        isLoading = true
        let nftToDelete = nfts[nftIndex]
        profileService.changeNFTLike(like: nftToDelete.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.nfts.removeAll(where: { $0.id == nftToDelete.id })
            case .failure(let error):
                print("Ошибка отправки лайка: \(error)")
            }
            self.isLoading = false
        }
    }
    
    func configureCellModel(nftIndex: Int) -> FavoriteNFTsCellModel {
        let nft = nfts[nftIndex]
        
        return FavoriteNFTsCellModel(
            name: nft.name,
            image: nft.images.first ?? "",
            rating: nft.rating,
            price: "\(nft.price) ETH"
        )
    }
}
