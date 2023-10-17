//
//  ProfileEditingViewModel.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 03.08.2023.
//

import Foundation

final class ProfileEditingViewModel: ProfileEditingViewModelProtocol {
    
    //MARK: - Observables
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
    
    @Observable
    private(set) var isLoading: Bool = false
    
    //MARK: - Properties
    var profileObservable: Observable<ProfileModel> { $profile }
    var isLoadingObservable: Observable<Bool> { $isLoading }
    var delegate: ProfileEditingDelegate?
    
    private let profileService: ProfileServiceProtocol
    
    //MARK: - LifeCycle
    init(profileService: ProfileServiceProtocol = ProfileService()) {
        self.profileService = profileService
    }
    
    //MARK: - Methods
    func updateProfile(profileToSet: ProfileModel) {
        profile = profileToSet
    }
    
    func changeProfileName(nameToSet: String) {
        isLoading = true
        profileService.changeProfileName(nameToSet: nameToSet) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let body):
                self.profile = body
                self.delegate?.updateProfileFields()
            case .failure(let error):
                print("Ошибка изменения имени профиля: \(error)")
            }
            self.isLoading = false
        }
    }
    
    func changeProfileDescription(descriptionToSet: String) {
        isLoading = true
        profileService.changeProfileDescription(descriptionToSet: descriptionToSet) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let body):
                self.profile = body
                self.delegate?.updateProfileFields()
            case .failure(let error):
                print("Ошибка изменения описания профиля: \(error)")
            }
            self.isLoading = false
        }
    }
    
    func changeProfileWebsite(websiteToSet: String) {
        isLoading = true
        profileService.changeProfileWebsite(websiteToSet: websiteToSet) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let body):
                self.profile = body
                self.delegate?.updateProfileFields()
            case .failure(let error):
                print("Ошибка изменения сайта профиля: \(error)")
            }
            self.isLoading = false
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
