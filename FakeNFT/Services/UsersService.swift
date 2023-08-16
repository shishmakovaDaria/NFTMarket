//
//  UsersService.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 16.08.2023.
//

import Foundation


final class UsersService: UsersServiceProtocol {
    
    var networkClient: NetworkClient
    let getUsersRequest: NetworkRequest
    
    init(
        networkClient: NetworkClient = DefaultNetworkClient(),
        getUsersRequest: NetworkRequest = GetUsersRequest()
    ) {
        self.networkClient = networkClient
        self.getUsersRequest = getUsersRequest
    }
    
    func getUsers(completion: @escaping (Result<[UserModel], Error>) -> Void) {
        networkClient.send(request: getUsersRequest, type: [UserModel].self) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
