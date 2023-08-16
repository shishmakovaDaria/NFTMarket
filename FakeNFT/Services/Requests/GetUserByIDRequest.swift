//
//  GetUserByIDRequest.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 16.08.2023.
//

import Foundation


struct GetUserByIDRequest: NetworkRequest {
    let userID: String
    var endpoint: URL? {
        Constants.endpoint.appendingPathComponent("/users/\(userID)")
    }
    var httpMethod: HttpMethod { .get }
}
