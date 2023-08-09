//
//  CollectionViewModel.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 08.08.2023.
//

import Foundation
import ProgressHUD

final class CollectionViewModel {
    // MARK: - Observables
    @Observable
    private (set) var nfts: [NFTModel] = []
    @Observable
    private (set) var likes: [String] = []
    
    //MARK: - Properties:
    
    private let nftCollection: [String]
    
    //MARK: - Servicies
    let nftService = NFTService()
    let profileService = ProfileService()
    
    //MARK: - LifeCycle
    
    init(nfts: [String]) {
        self.nftCollection = nfts
        self.getNFTModel()
        self.getProfile()
    }
    
    //MARK: - Actions:
    
    func likeButtonTapped(id: String) {
        profileService.changeNFTLike(like: id) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let profile):
                self.likes = profile.likes
                UIBlockingProgressHUD.dismiss()
            case .failure(let error):
                print("Ошибка обновления лайка: \(error)")
                UIBlockingProgressHUD.dismiss()
            }
        }
    }
    
    //MARK: - Methods
    
    private func getNFTModel() {
        nftCollection.forEach { nftID in
            nftService.getNFT(with: nftID) { [ weak self ] result in
                guard let self else { return }
                switch result {
                case .success(let nft):
                    self.nfts.append(nft)
                    self.sortNFT()
                case .failure(let error):
                    print("Ошибка получения NFT: \(error)")
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
                print(self.likes)
            case .failure(let error):
                print("Ошибка получения лайков из профиля \(error)")
            }
        }
    }
    
    private func sortNFT() {
        nfts.sort {Int($0.id)! < Int($1.id)!}
    }
}
