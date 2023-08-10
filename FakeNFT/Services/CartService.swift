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
}


struct CartService {
    
    let networkClient = DefaultNetworkClient()
    let getOrderNFTs = GetOrderRequest()
    let nftService = NFTService()
    
    func getOrder(completion: @escaping (Result<[String], Error>) -> Void) {
        networkClient.send(request: getOrderNFTs, type: OrderModel.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let order):
                    completion(.success(order.nfts))
//                    if order.nfts.isEmpty {
//                        completion(.success([]))
//                        return
//                    } else {
//                        print("IDs: \(order.nfts)")
//                        var nfts: [NFTModel] = []
//                        order.nfts.forEach { id in
//                            nftService.getNFT(with: id) { result in
//                                switch result {
//                                case .success(let nft):
//                                    nfts.append(nft)
//                                    print("\(nfts.count) nfts on service")
//                                case .failure(let error):
//                                    print(error.localizedDescription)
//                                }
//                            }
//                        }
//                        print("\(nfts.count) nfts for exit ")
//                        completion(.success(nfts))
//                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
