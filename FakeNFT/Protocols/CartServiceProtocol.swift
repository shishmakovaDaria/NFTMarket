//
//  CartServiceProtocol.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 16.08.2023.
//

import Foundation

protocol CartServiceProtocol {
    var networkClient: NetworkClient { get }
    func getOrder(completion: @escaping (Result<[String], Error>) -> Void)
    func updateOrder(updatedOrder: [String], completion: @escaping (Result<OrderModel, Error>) -> Void)
}
