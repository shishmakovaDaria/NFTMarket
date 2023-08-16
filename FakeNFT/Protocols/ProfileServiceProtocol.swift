//
//  ProfileServiceProtocol.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 16.08.2023.
//

import Foundation

protocol ProfileServiceProtocol {
    var networkClient: NetworkClient { get }
    func getProfile(completion: @escaping (Result<ProfileModel, Error>) -> Void)
    func changeProfileName(nameToSet: String, completion: @escaping (Result<ProfileModel, Error>) -> Void)
    func changeProfileDescription(descriptionToSet: String, completion: @escaping (Result<ProfileModel, Error>) -> Void)
    func changeProfileWebsite(websiteToSet: String, completion: @escaping (Result<ProfileModel, Error>) -> Void)
    func changeNFTLike(like: String, completion: @escaping (Result<ProfileModel, Error>) -> Void)
    func changeProfileLikes(likesToSet: [String], completion: @escaping (Result<ProfileModel, Error>) -> Void)
}
