//
//  CartService.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 07.08.2023.
//

import Foundation

struct GetOrderRequest: NetworkRequest {
    var endpoint: URL? {
        Constants.endpoint?.appendingPathComponent("/orders/1")
    }
}


struct CartService {
    
    let networkClient = DefaultNetworkClient()
    let getOrderNFTs = GetOrderRequest()
    
    func getNFTs(completion: @escaping (Result<[NFTModel], Error>) -> Void) {
        networkClient.send(request: getOrderNFTs, type: OrderModel.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let order):
                    guard !order.nfts.isEmpty else { // проверка пустой корзины
                        completion(.success([]))
                        return
                    }
                    // TO DO
                    
                    
                    
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
