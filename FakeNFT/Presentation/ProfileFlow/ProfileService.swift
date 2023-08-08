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

struct ChangeProfileRequest: NetworkRequest {
    var endpoint: URL? {
        return URL(string: "https://64c51731c853c26efada7bb6.mockapi.io/api/v1/profile/1")
    }
    var httpMethod: HttpMethod { .put }
    
    var dto: Encodable?
}

final class ProfileService {
    
    private let networkClient = DefaultNetworkClient()

    func getProfile(completion: @escaping (Result<ProfileModel, Error>) -> Void) {
        let getProfileRequest = GetProfileRequest()
        
        networkClient.send(request: getProfileRequest, type: ProfileModel.self) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func changeProfileName(nameToSet: String, completion: @escaping (Result<ProfileModel, Error>) -> Void) {
        let changeProfileNameRequest = ChangeProfileRequest(dto: ["name": nameToSet])
        
        networkClient.send(request: changeProfileNameRequest, type: ProfileModel.self) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func changeProfileDescription(descriptionToSet: String, completion: @escaping (Result<ProfileModel, Error>) -> Void) {
        let changeProfileDescriptionRequest = ChangeProfileRequest(dto: ["description": descriptionToSet])
        
        networkClient.send(request: changeProfileDescriptionRequest, type: ProfileModel.self) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func changeProfileWebsite(websiteToSet: String, completion: @escaping (Result<ProfileModel, Error>) -> Void) {
        let changeProfileWebsiteRequest = ChangeProfileRequest(dto: ["website": websiteToSet])
        
        networkClient.send(request: changeProfileWebsiteRequest, type: ProfileModel.self) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func changeNFTLike(like: String, completion: @escaping (Result<ProfileModel, Error>) -> Void) {
        getProfile { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let profile):
                var likes = profile.likes
                if likes.contains(like) == true {
                    if let index = likes.firstIndex(of: like) {
                        likes.remove(at: index)
                    }
                    self.changeProfileLikes(likesToSet: likes) { result in
                        completion(result)
                    }
                } else {
                    likes.append(like)
                    likes.sort { Int($0) ?? 0 < Int($1) ?? 0 }
                    self.changeProfileLikes(likesToSet: likes) { result in
                        completion(result)
                    }
                }
            case .failure(let error):
                print("Ошибка получения профиля: \(error)")
            }
        }
    }
    
    private func changeProfileLikes(likesToSet: [String], completion: @escaping (Result<ProfileModel, Error>) -> Void) {
        let changeProfileLikesRequest = ChangeProfileRequest(dto: ["likes": likesToSet])
        
        networkClient.send(request: changeProfileLikesRequest, type: ProfileModel.self) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
