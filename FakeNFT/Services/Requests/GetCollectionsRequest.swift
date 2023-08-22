//
//  GetCollectionsRequest.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 22.08.2023.
//

import Foundation

struct GetCollectionsRequest: NetworkRequest {
    var endpoint: URL? {
        Constants.endpoint.appendingPathComponent("/collections")
    }
    var httpMethod: HttpMethod { .get }
}
