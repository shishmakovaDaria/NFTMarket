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
    @Observable
    private (set) var likes: [String] = []
    @Observable
    private (set) var cartNFTs: [String] = []
    @Observable
    private (set) var isLoading = false
    
    //MARK: - Properties:
    
    private let nftCollection: [String]
    
    //MARK: - Servicies
    let nftService: NFTService
    let profileService: ProfileService
    let cartService: CartService
    
    //MARK: - LifeCycle
    
    init(nfts: [String], nftService: NFTService = NFTService(), profileService: ProfileService = ProfileService(), cartService: CartService = CartService()) {
        self.nftCollection = nfts
        self.nftService = nftService
        self.profileService = profileService
        self.cartService = cartService
        self.getOrder()
        self.getProfile()
        self.getNFTModel()
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
    
    func getCellModel(at indexPath: IndexPath) ->  NFTCollectionCellModel {
        let nftModel = nfts[indexPath.row]
        let isLiked = likes.contains(nftModel.id)
        let isInCart = cartNFTs.contains(nftModel.id)
        let nftCollectionCellModel = NFTCollectionCellModel(image: nftModel.images[0], rating: nftModel.rating, name: nftModel.name, price: nftModel.price, isLiked: isLiked, isInCart: isInCart)
        return nftCollectionCellModel
    }
    
    private func getNFTModel() {
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
    
    private func getProfile() {
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
        nfts.sort {Int($0.id)! < Int($1.id)!}
    }
}
