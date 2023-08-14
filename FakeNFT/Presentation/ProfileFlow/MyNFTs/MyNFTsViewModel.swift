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
    private(set) var nftsAuthors: [UserModel] = []
    
    var nftIDs: [String] = []
    var likedNFTs: [String] = []
    private let nftService: NFTService
    private let userByIDService: UserByIDService
    
    init(nftService: NFTService = NFTService(), userByIDService: UserByIDService = UserByIDService()) {
        self.nftService = nftService
        self.userByIDService = userByIDService
    }
    
    func updateNFTs() {
        var newNFTs: [NFTModel] = []
        nftIDs.forEach { nftID in
            nftService.getNFT(with: nftID) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let nft):
                    newNFTs.append(nft)
                case .failure(let error):
                    print("Ошибка получения NFT: \(error)")
                }
                self.nfts = newNFTs
                getNFTsAuthors()
            }
        }
    }
    
    func handleLikeButtonTapped(nftIndex: Int) {
        //добавить блокировку UI и HUD
        //добавить работу с сетью
    }
    
    func configureCellModel(nftIndex: Int) -> MyNFTsCellModel {
        let nft = nfts[nftIndex]
        let isLiked = likedNFTs.contains(nft.id)
        let author = getAuthor(id: nft.author)
        
        return MyNFTsCellModel(
            name: nft.name,
            image: nft.images.first ?? "",
            rating: nft.rating,
            author: "From".localized().lowercased() + " \(author)",
            price: "\(nft.price) ETH",
            isLiked: isLiked
        )
    }
    
    private func getNFTsAuthors() {
        var newAuthors: [UserModel] = []
        nfts.forEach { nft in
            userByIDService.getUserByID(with: nft.author) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let user):
                    newAuthors.append(user)
                case .failure(let error):
                    print("Ошибка получения автора NFT: \(error)")
                }
                self.nftsAuthors = newAuthors
            }
        }
    }
    
    private func getAuthor(id: String) -> String {
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
