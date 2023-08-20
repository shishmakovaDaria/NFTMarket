//
//  CollectionViewModel.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 08.08.2023.
//

import Foundation

final class CollectionViewModel: CollectionViewModelProtocol {
    
    // MARK: - Observables
    @Observable
    private (set) var nfts: [NFTModel] = []
    var nftsObservable: Observable<[NFTModel]> { $nfts }
    @Observable
    private (set) var likes: [String] = []
    var likesObservable: Observable<[String]> { $likes }
    @Observable
    private (set) var cartNFTs: [String] = []
    var cartNFTsObservable: Observable<[String]> { $cartNFTs }
    @Observable
    private (set) var isLoading = false
    var isLoadingObservable: Observable<Bool> { $isLoading }
    
    //MARK: - Properties:
    
    private let nftCollection: [String]
    
    //MARK: - Servicies
    let nftService: NFTServiceProtocol
    let profileService: ProfileServiceProtocol
    let cartService: CartServiceProtocol
    
    //MARK: - LifeCycle
    
    init(nfts: [String], nftService: NFTServiceProtocol = NFTService(), profileService: ProfileServiceProtocol = ProfileService(), cartService: CartServiceProtocol = CartService()) {
        self.nftCollection = nfts
        self.nftService = nftService
        self.profileService = profileService
        self.cartService = cartService
    }
    
    //MARK: - Actions:
    
    func likeButtonTapped(at indexPath: IndexPath) {
        let nftModel = nfts[indexPath.row]
        isLoading = true
        profileService.changeNFTLike(like: nftModel.id) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let profile):
                self.likes = profile.likes
                isLoading = false
            case .failure(let error):
                print("Ошибка обновления лайка: \(error)")
                isLoading = false
            }
        }
    }
    
    func cartButtonTapped(at indexPath: IndexPath) {
        let nftModel = nfts[indexPath.row]
        var updateCart = cartNFTs
        isLoading = true
        if updateCart.contains(nftModel.id) {
            guard let index = cartNFTs.firstIndex(of: nftModel.id) else { return }
            updateCart.remove(at: index)
        } else {
            updateCart.append(nftModel.id)
        }
        cartService.updateOrder(updatedOrder: updateCart) {[weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let order):
                    self.cartNFTs = order.nfts
                    self.isLoading = false
                case .failure(let error):
                    print("Ошибка обновления корзины: \(error)")
                    self.isLoading = false
                }
            }
        }
    }
    
    //MARK: - Methods
    
    func viewDidLoad() {
        getOrder()
        getLikesFromProfile()
        getNFTModel()
    }
    
    func getCellModel(at indexPath: IndexPath) ->  NFTCollectionCellModel {
        let nftModel = nfts[indexPath.row]
        let isLiked = likes.contains(nftModel.id)
        let isInCart = cartNFTs.contains(nftModel.id)
        let nftCollectionCellModel = NFTCollectionCellModel(image: nftModel.images[0], rating: nftModel.rating, name: nftModel.name, price: nftModel.price, isLiked: isLiked, isInCart: isInCart)
        return nftCollectionCellModel
    }
    
    private func getNFTModel() {
        if !nftCollection.isEmpty {
            self.isLoading = true
            nftCollection.forEach { nftID in
                nftService.getNFT(with: nftID) { [ weak self ] result in
                    guard let self else { return }
                    switch result {
                    case .success(let nft):
                        self.nfts.append(nft)
                        self.sortNFT()
                        self.isLoading = false
                    case .failure(let error):
                        print("Ошибка получения NFT: \(error)")
                        self.isLoading = false
                    }
                }
            }
        }
    }
    
    private func getLikesFromProfile() {
        profileService.getProfile { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let profile):
                self.likes = profile.likes
            case .failure(let error):
                print("Ошибка получения лайков из профиля \(error)")
            }
        }
    }
    
    private func getOrder() {
        cartService.getOrder { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let order):
                self.cartNFTs = order
            case .failure(let error):
                print("Ошибка получения корзины из ордера \(error)")
            }
        }
    }
    
    private func sortNFT() {
        nfts.sort { (nft1, nft2) -> Bool in
            if let id1 = Int(nft1.id), let id2 = Int(nft2.id) {
                return id1 < id2
            }
            return false
        }
    }
}
