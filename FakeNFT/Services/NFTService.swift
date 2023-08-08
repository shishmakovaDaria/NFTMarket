//
//  NFTService.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 08.08.2023.
//

import Foundation

struct GetNFTRequest: NetworkRequest {
    let NFTID: String
    var endpoint: URL? {
        return URL(string: "https://64c51731c853c26efada7bb6.mockapi.io/api/v1/nft/\(NFTID)")
    }
    var httpMethod: HttpMethod { .get }
}

final class NFTService {
    let networkClient = DefaultNetworkClient()
    
    func getNFT(with NFTID: String, completion: @escaping (Result<NFTModel, Error>) -> Void) {
        let getNFTRequest = GetNFTRequest(NFTID: NFTID)
        networkClient.send(request: getNFTRequest, type: NFTModel.self) { result in
                DispatchQueue.main.async {
                    completion(result)
                }
        }
    }
}
