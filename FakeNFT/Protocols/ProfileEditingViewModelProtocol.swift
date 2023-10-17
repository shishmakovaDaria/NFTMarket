//
//  ProfileEditingViewModelProtocol.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 17.10.2023.
//

import Foundation

protocol ProfileEditingViewModelProtocol {
    var profile: ProfileModel { get }
    var profileObservable: Observable<ProfileModel> { get }
    var isLoading: Bool { get }
    var isLoadingObservable: Observable<Bool> { get }
    var delegate: ProfileEditingDelegate? { get }
    
    func updateProfile(profileToSet: ProfileModel)
    func changeProfileName(nameToSet: String)
    func changeProfileDescription(descriptionToSet: String)
    func changeProfileWebsite(websiteToSet: String)
    func changeProfileAvatar()
    func provideAvatarURL() -> URL?
}
