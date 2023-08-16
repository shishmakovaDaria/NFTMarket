//
//  UsersService.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 06.08.2023.
//

import Foundation

struct GetUsersRequest: NetworkRequest {
    var endpoint: URL? {
        return URL(string: "https://64c51731c853c26efada7bb6.mockapi.io/api/v1/users")
    }
    var httpMethod: HttpMethod { .get }
}

final class UsersService {
    let networkClient = DefaultNetworkClient()
    let getUsersRequest = GetUsersRequest()

    func getUsers(completion: @escaping (Result<[UserModel], Error>) -> Void) {
        networkClient.send(request: getUsersRequest, type: [UserModel].self) { result in
                DispatchQueue.main.async {
                    completion(result)
                }
        }
    }
}



