//
//  CollectionsServiceProtocol.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 22.08.2023.
//

import Foundation

protocol CollectionsServiceProtocol {
    var networkClient: NetworkClient { get }
    func getCollections(completion: @escaping (Result<[CollectionModel], Error>) -> Void)
}
