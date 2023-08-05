//
//  NFTModel.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 05.08.2023.
//

import Foundation

struct NFTModel: Codable {
    let createdAt: String
    let name: String
    let images: [String]
    let rating: Int
    let description: String
    let price: Float
    let author: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case createdAt
        case name
        case images
        case rating
        case description
        case price
        case author
        case id
    }
}
