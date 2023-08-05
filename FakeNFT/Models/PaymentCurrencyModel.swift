//
//  PaymentCurrencyModel.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 05.08.2023.
//

import Foundation

struct PaymentCurrencyModel: Codable {
    let success: Bool
    let orderId: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case orderId
        case id
    }
}
