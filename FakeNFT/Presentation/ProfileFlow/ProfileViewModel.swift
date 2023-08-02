//
//  ProfileViewModel.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 01.08.2023.
//

import Foundation

final class ProfileViewModel {

    let profile = ProfileModel(name: "Joaquin Phoenix",
                                       avatar: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/Cable_Car_No._1_and_Alcatraz_Island.jpg/1024px-Cable_Car_No._1_and_Alcatraz_Island.jpg",
                                       description: "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.",
                                       website: "Joaquin Phoenix.com",
                                       nfts: ["", "", ""],
                                       likes: [""],
                                       id: "1")

    
    func provideTableHeaders() -> [String] {
        let tableHeaders: [String] = [
            "\("My NFTs".localized()) (\(profile.nfts.count))",
            "\("Favorite NFTs".localized()) (\(profile.likes.count))",
            "About the developer".localized()
        ]
        return tableHeaders
    }
}
