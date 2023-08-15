//
//  MyNFTsViewModel.swift
//  FakeNFT
// 
//  Created by Дарья Шишмакова on 08.08.2023.
//

import Foundation

final class MyNFTsViewModel {
    
    @Observable
    private(set) var nfts: [NFTModel] = []
    
    @Observable
    private(set) var likes: [String] = []
    
    @Observable
    private(set) var nftsAuthors: [UserModel] = []
    
    var nftIDs: [String] = []
    var nftsAuthorsIDs: Set<String> = []
    private let nftService: NFTService
    private let userByIDService: UserByIDService
    private let profileService: ProfileService
    
    init(
        nftService: NFTService = NFTService(),
        userByIDService: UserByIDService = UserByIDService(),
        profileService: ProfileService = ProfileService()
    ) {
        self.nftService = nftService
        self.userByIDService = userByIDService
        self.profileService = profileService
    }
    
    func setValues(myNFTS: [String], myLikedNFTs: [String]) {
        nftIDs = myNFTS
        likes = myLikedNFTs
    }
    
    func updateNFTs() {
        nftIDs.forEach { nftID in
            nftService.getNFT(with: nftID) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let nft):
                    self.nfts.append(nft)
                    self.nftsAuthorsIDs.insert(nft.author)
                case .failure(let error):
                    print("Ошибка получения NFT: \(error)")
                }
                getNFTsAuthors()
            }
        }
    }
    
    func handleLikeButtonTapped(nftIndex: Int) {
        //добавить блокировку UI и HUD
        let nft = nfts[nftIndex]
        profileService.changeNFTLike(like: nft.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let profile):
                likes = profile.likes
            case .failure(let error):
                print("Ошибка отправки лайка: \(error)")
            }
        }
    }
    
    func configureCellModel(nftIndex: Int) -> MyNFTsCellModel {
        let nft = nfts[nftIndex]
        let author = setAuthorName(id: nft.author)
        
        return MyNFTsCellModel(
            name: nft.name,
            image: nft.images.first ?? "",
            rating: nft.rating,
            author: "From".localized().lowercased() + " \(author)",
            price: "\(nft.price) ETH",
            isLiked: likes.contains(nft.id)
        )
    }
    
    func getNFTsAuthors() {
        if nfts.count == nftIDs.count { //проверяем, что все nft подгрузились
            nftsAuthorsIDs.forEach { id in
                userByIDService.getUserByID(with: id) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let user):
                        self.nftsAuthors.append(user)
                    case .failure(let error):
                        print("Ошибка получения автора NFT: \(error)")
                    }
                }
            }
        }
    }
    
    private func setAuthorName(id: String) -> String {
        var authorToSet = ""
        nftsAuthors.forEach { author in
            if author.id == id {
                authorToSet = author.name
            }
        }
        
        return authorToSet
    }
}

//MARK: - UITableViewDelegate
extension MyNFTsViewModel: ViewModelProtocol {
    func sort(param: Sort) {
        switch param {
        case .price:
            nfts = nfts.sorted(by: { $0.price > $1.price })
        case .rating:
            nfts = nfts.sorted(by: { $0.rating > $1.rating })
        case .NFTName:
            nfts = nfts.sorted(by: { $0.name < $1.name })
        case .name:
            break
        case .NFTCount:
            break
        }
    }
}
