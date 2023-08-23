//
//  PutOrderRequest.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 16.08.2023.
//

import Foundation

struct PutOrderRequest: NetworkRequest {
    var endpoint: URL? {
        Constants.endpoint.appendingPathComponent("/orders/1")
    }
    
    var httpMethod: HttpMethod { .put }
    
    var dto: Encodable?
}
