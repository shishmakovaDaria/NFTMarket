//
//  ProfileModel.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 03.08.2023.
//

import Foundation

struct UserModel: Codable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [String]
    let rating: String
    let id: String
}

struct UsersModel: Codable {
    let user: [UserModel]
}
