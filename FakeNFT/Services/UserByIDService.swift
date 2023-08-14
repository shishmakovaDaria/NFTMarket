//
//  UserById.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 14.08.2023.
//

import Foundation

struct GetUserByIDRequest: NetworkRequest {
    let userID: String
    var endpoint: URL? {
        Constants.endpoint.appendingPathComponent("/users/\(userID)")
    }
    var httpMethod: HttpMethod { .get }
}

final class UserByIDService {
    let networkClient = DefaultNetworkClient()

    func getUserByID(with userID: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        let getUserByIDRequest = GetUserByIDRequest(userID: userID)
        
        networkClient.send(request: getUserByIDRequest, type: UserModel.self) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
