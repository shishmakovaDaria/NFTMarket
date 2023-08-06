//
//  OrderModel.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 05.08.2023.
//

import Foundation

struct OrderModel: Codable {
    let nfts: [String]
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case nfts
        case id
    }
}
