//
//  GetUsersRequest.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 16.08.2023.
//

import Foundation


struct GetUsersRequest: NetworkRequest {
    var endpoint: URL? {
        Constants.endpoint.appendingPathComponent("/users")
    }
    var httpMethod: HttpMethod { .get }
}
