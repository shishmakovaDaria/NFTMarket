//
//  CollectionsService.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 22.08.2023.
//

import Foundation

final class CollectionsService: CollectionsServiceProtocol {
    
    var networkClient: NetworkClient
    let getCollectionsRequest: NetworkRequest
    
    init(
        networkClient: NetworkClient = DefaultNetworkClient(),
        getCollectionsRequest: NetworkRequest = GetCollectionsRequest()
    ) {
        self.networkClient = networkClient
        self.getCollectionsRequest = getCollectionsRequest
    }
    
    func getCollections(completion: @escaping (Result<[CollectionModel], Error>) -> Void) {
        networkClient.send(request: getCollectionsRequest, type: [CollectionModel].self) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
