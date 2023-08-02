//
//  DataProvider.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 02.08.2023.
//

import Foundation


final class DataProvider {
    func getUserInfo() -> ProfileModel {
        let mockProfile = ProfileModel(name: "Joaquin Phoenix",
                                           avatar: "https://code.s3.yandex.net/landings-v2-ios-developer/space.PNG",
                                           description: "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.",
                                           website: "https://practicum.yandex.ru/ios-developer",
                                           nfts: ["", "", ""],
                                           likes: [""],
                                           id: "1")
        return mockProfile
    }
}
