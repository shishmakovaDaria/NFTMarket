//
//  ProfileEditingViewModel.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 03.08.2023.
//

import Foundation

protocol ProfileEditingDelegate: AnyObject {
    func updateProfileFields()
}

final class ProfileEditingViewModel {
    
    @Observable
    private(set) var profile = ProfileModel(
        name: "",
        avatar: "",
        description: "",
        website: "",
        nfts: [],
        likes: [],
        id: ""
    )
    
    var delegate: ProfileEditingDelegate?
    private let profileService: ProfileService
    
    init(profileService: ProfileService = ProfileService()) {
        self.profileService = profileService
    }
    
    func updateProfile(profileToSet: ProfileModel) {
        profile = profileToSet
    }
    
    func changeProfileName(nameToSet: String) {
        profileService.changeProfileName(nameToSet: nameToSet) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let body):
                self.profile = body
                self.delegate?.updateProfileFields()
            case .failure(let error):
                print("Ошибка изменения имени профиля: \(error)")
            }
        }
    }
    
    func changeProfileDescription(descriptionToSet: String) {
        profileService.changeProfileDescription(descriptionToSet: descriptionToSet) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let body):
                self.profile = body
                self.delegate?.updateProfileFields()
            case .failure(let error):
                print("Ошибка изменения описания профиля: \(error)")
            }
        }
    }
    
    func changeProfileWebsite(websiteToSet: String) {
        profileService.changeProfileWebsite(websiteToSet: websiteToSet) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let body):
                self.profile = body
                self.delegate?.updateProfileFields()
            case .failure(let error):
                print("Ошибка изменения сайта профиля: \(error)")
            }
        }
    }
    
    func changeProfileAvatar() {
        let newProfile = ProfileModel(
            name: profile.name,
            avatar: "https://upload.wikimedia.org/wikipedia/commons/e/e6/Ryan_Gosling_by_Gage_Skidmore.jpg",
            description: profile.description,
            website: profile.website,
            nfts: profile.nfts,
            likes: profile.likes,
            id: profile.id
        )
        profile = newProfile
    }
    
    func provideAvatarURL() -> URL? {
        let url = URL(string: profile.avatar)
        return url
    }
}
