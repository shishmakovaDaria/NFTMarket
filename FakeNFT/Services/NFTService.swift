//
//  File.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 08.08.2023.
//

import Foundation


final class NFTService {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }
    
    func getNFT(with NFTID: String, completion: @escaping (Result<NFTModel, Error>) -> Void) {
        let getNFTRequest = GetNFTRequest(NFTID: NFTID)
        networkClient.send(request: getNFTRequest, type: NFTModel.self) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
