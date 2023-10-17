//
//  NFTServiceProtocol.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 16.08.2023.
//

import Foundation

protocol NFTServiceProtocol {
    var networkClient: NetworkClient { get }
    func getNFT(with NFTID: String, completion: @escaping (Result<NFTModel, Error>) -> Void)
}
