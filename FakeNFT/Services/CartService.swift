//
//  CartService.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 07.08.2023.
//

import Foundation

struct GetOrderRequest: NetworkRequest {
    var endpoint: URL? {
        Constants.endpoint.appendingPathComponent("/orders/1")
    }
    
    var httpMethod: HttpMethod { .get }
}

struct PutOrderRequest: NetworkRequest {
    var endpoint: URL? {
        Constants.endpoint.appendingPathComponent("/orders/1")
    }
    
    var httpMethod: HttpMethod { .put }
    
    var dto: Encodable?
}

struct CartService {
    
    var networkClient: DefaultNetworkClient
    var getOrderNFTs: GetOrderRequest
    
    init(networkClient: DefaultNetworkClient = DefaultNetworkClient(), getOrderNFTs: GetOrderRequest = GetOrderRequest()) {
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
                print(order)
                completion(.success(order))
                case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
