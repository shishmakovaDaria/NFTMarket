//
//  MyNFTsViewModel.swift
//  FakeNFT
// 
//  Created by Дарья Шишмакова on 08.08.2023.
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

final class MyNFTsViewModel: MyNFTsViewModelProtocol {
    
    @Observable
    private(set) var nfts: [NFTModel] = []
    
    @Observable
    private(set) var likes: [String] = []
    
    @Observable
    private(set) var nftsAuthors: [UserModel] = []
    
    @Observable
    private(set) var isLoading: Bool = false
    
    var nftsObservable: Observable<[NFTModel]> { $nfts }
    var likesObservable: Observable<[String]> { $likes }
    var nftsAuthorsObservable: Observable<[UserModel]> { $nftsAuthors }
    var isLoadingObservable: Observable<Bool> { $isLoading }
    
    private var nftIDs: [String] = []
    private var nftsAuthorsIDs: Set<String> = []
    private let nftService: NFTServiceProtocol
    private let userByIDService: UserByIDServiceProtocol
    private let profileService: ProfileServiceProtocol
    
    init(
        nftService: NFTServiceProtocol = NFTService(),
        userByIDService: UserByIDServiceProtocol = UserByIDService(),
        profileService: ProfileServiceProtocol = ProfileService()
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
        isLoading = true
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
                if nfts.count == nftIDs.count {
                    isLoading = false
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
    
    private func getNFTsAuthors() {
        isLoading = true
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
                    isLoading = false
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
extension MyNFTsViewModel: Sortable {
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
