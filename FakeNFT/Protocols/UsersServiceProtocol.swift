//
//  UsersServiceProtocol.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 16.08.2023.
//

import Foundation

protocol UsersServiceProtocol {
    var networkClient: NetworkClient { get }
    func getUsers(completion: @escaping (Result<[UserModel], Error>) -> Void)
}
