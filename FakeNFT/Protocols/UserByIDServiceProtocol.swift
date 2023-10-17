//
//  UserByIDServiceProtocol.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 16.08.2023.
//

import Foundation

protocol UserByIDServiceProtocol {
    var networkClient: NetworkClient { get }
    func getUserByID(with userID: String, completion: @escaping (Result<UserModel, Error>) -> Void)
}
