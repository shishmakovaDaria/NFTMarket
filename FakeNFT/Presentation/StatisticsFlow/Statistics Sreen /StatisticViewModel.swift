//
//  StatisticViewModel.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 02.08.2023.
//

import UIKit

final class StatisticViewModel {
    // MARK: - Observables
    @Observable
    private (set) var users: [UserModel] = []
    
    //MARK: - Servicies
    let usersService = UsersService()
    
    // MARK: - Methods
    func startObserve() {
        getUsers()
    }
    
    private func getStats() {
        users = mockUsers
    }
    
    private func getUsers() {
        usersService.getUsers {result in
            switch result {
            case let .success(users):
                self.users = users
            case let .failure(error):
                print("Ошибка получения списка рейтинга юзеров: \(error)")
                
            }
        }
    }
}

extension StatisticViewModel: ViewModelProtocol {
    func sort(param: Sort) {
        if param == .rating {
            users.sort { $0.rating < $1.rating}
        } else if param == .name {
            users.sort { $0.name < $1.name }
        }
    }
}

//let mockStatsCells: [StatisticCellModel] = [
//    StatisticCellModel(name: "apeCoin", avatar: .Icons.apeCoin!, rating: 1),
//    StatisticCellModel(name: "bitcoin", avatar: .Icons.bitcoin!, rating: 2),
//    StatisticCellModel(name: "cardano", avatar: .Icons.cardano!, rating: 3),
//    StatisticCellModel(name: "dogecoin", avatar: .Icons.dogecoin!, rating: 4),
//    StatisticCellModel(name: "apeCoin", avatar: .Icons.apeCoin!, rating: 5),
//    StatisticCellModel(name: "ethereum", avatar: .Icons.ethereum!, rating: 6),
//    StatisticCellModel(name: "shibaInu", avatar: .Icons.shibaInu!, rating: 7),
//    StatisticCellModel(name: "solana", avatar: .Icons.solana!, rating: 8),
//    StatisticCellModel(name: "tether", avatar: .Icons.tether!, rating: 9),
//]

let mockUsers: [UserModel] = [
    UserModel( name: "Jackson Cooper",
               avatar: "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/879.jpg",
               description: "Building a diverse NFT collection from all corners of the globe 🌍",
               website: "https://practicum.yandex.ru/java-developer/",
               nfts: ["1"],
               rating: "67",
               id: "11"),
    UserModel( name: "Nicholas Flores",
               avatar: "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/492.jpg",
               description: "The NFT world never ceases to amaze me 🤯",
               website: "https://practicum.yandex.ru/ycloud/",
               nfts: [],
               rating: "66",
               id: "12"),
    UserModel(
        name: "Isaac Kim",
        avatar: "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/255.jpg",
        description: "Investing in NFTs for the long haul 💰",
        website: "https://practicum.yandex.ru/go-advanced/",
        nfts: [],
        rating: "65",
        id: "13"
    ),
    UserModel(
        name: "Cole Harris",
        avatar: "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/421.jpg",
        description: "NFTs are my way of owning a piece of art history 🎭",
        website: "https://practicum.yandex.ru/devops/",
        nfts: [],
        rating: "64",
        id: "14"
    )
]
