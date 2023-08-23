//
//  GetCurrenciesRequest.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 16.08.2023.
//

import Foundation


struct GetCurrenciesRequest: NetworkRequest {
    var endpoint: URL? {
        Constants.endpoint.appendingPathComponent("/currencies")
    }
    
    var httpMethod: HttpMethod { .get }
}
