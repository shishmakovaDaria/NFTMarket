//
//  CartService.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 16.08.2023.
//

import Foundation


struct CartService: CartServiceProtocol {
    
    let networkClient: NetworkClient
    let getOrderNFTs: NetworkRequest
    
    init(
        networkClient: NetworkClient = DefaultNetworkClient(),
        getOrderNFTs: NetworkRequest = GetOrderRequest()
    ) {
        self.networkClient = networkClient
        self.getOrderNFTs = getOrderNFTs
    }
    
    func getOrder(completion: @escaping (Result<[String], Error>) -> Void) {
        networkClient.send(request: getOrderNFTs, type: OrderModel.self) { result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let order):
                    completion(.success(order.nfts))
                    case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func updateOrder(updatedOrder: [String], completion: @escaping (Result<OrderModel, Error>) -> Void) {
        let putOrderRequest = PutOrderRequest(dto: ["nfts": updatedOrder])
        networkClient.send(request: putOrderRequest, type: OrderModel.self) { result in
            switch result {
                case .success(let order):
                completion(.success(order))
                case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
