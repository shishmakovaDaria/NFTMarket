//
//  UserByIDService.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 16.08.2023.
//

import Foundation


final class UserByIDService: UserByIDServiceProtocol {
    
    let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }
    
    func getUserByID(with userID: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        let getUserByIDRequest = GetUserByIDRequest(userID: userID)
        
        networkClient.send(request: getUserByIDRequest, type: UserModel.self) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
