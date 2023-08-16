//
//  ChangeProfileRequest.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 16.08.2023.
//

import Foundation

struct ChangeProfileRequest: NetworkRequest {
    var endpoint: URL? {
        Constants.endpoint.appendingPathComponent("/profile/1")
    }
    var httpMethod: HttpMethod { .put }
    
    var dto: Encodable?
}
