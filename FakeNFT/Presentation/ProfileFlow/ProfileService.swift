//
//  ProfileService.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 07.08.2023.
//

import Foundation

struct GetProfileRequest: NetworkRequest {
    var endpoint: URL? {
        return URL(string: "https://64c51731c853c26efada7bb6.mockapi.io/api/v1/profile/1")
    }
    var httpMethod: HttpMethod { .get }
}

final class ProfileService {
    let networkClient = DefaultNetworkClient()
    let getProfileRequest = GetProfileRequest()

    func getProfile(completion: @escaping (Result<ProfileModel, Error>) -> Void) {
        networkClient.send(request: getProfileRequest, type: ProfileModel.self) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
