//
//  PaymentOrderRequest.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 16.08.2023.
//

import Foundation


struct PaymentOrderRequest: NetworkRequest {
    private let id: String
    
    var endpoint: URL? {
        Constants.endpoint.appendingPathComponent("/orders/1/payment/\(id)")
    }
    
    var httpMethod: HttpMethod { .get }
    
    init(id: String) {
        self.id = id
    }
}
