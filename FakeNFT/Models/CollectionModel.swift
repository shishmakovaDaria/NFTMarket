//
//  CollectionModel.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 05.08.2023.
//

import Foundation

struct CollectionModel: Codable {
    let createdAt: String
    let name: String
    let cover: String
    let nfts: [String]
    let description: String
    let author: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case createdAt
        case name
        case cover
        case nfts
        case description
        case author
        case id
    }
}
