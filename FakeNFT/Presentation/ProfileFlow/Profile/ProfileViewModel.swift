//
//  ProfileViewModel.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 01.08.2023.
//

import Foundation

protocol ProfileViewModelProtocol: ProfileEditingDelegate {
    var profile: ProfileModel { get }
    var profileObservable: Observable<ProfileModel> { get }
    var isLoading: Bool { get }
    var isLoadingObservable: Observable<Bool> { get }
    var tableHeaders: [String] { get }
    
    func updateProfile()
    func provideAvatarURL() -> URL?
    func provideWebsiteURL() -> URL?
}

final class ProfileViewModel: ProfileViewModelProtocol {
    
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
    
    var tableHeaders: [String] {
        let tableHeaders: [String] = [
            "\("My NFTs".localized()) (\(profile.nfts.count))",
            "\("Favorite NFTs".localized()) (\(profile.likes.count))",
            "About the developer".localized()
        ]
        return tableHeaders
    }
    
    var profileObservable: Observable<ProfileModel> { $profile }
    var isLoadingObservable: Observable<Bool> { $isLoading }
    
    private let profileService: ProfileServiceProtocol
    
    init(profileService: ProfileServiceProtocol = ProfileService()) {
        self.profileService = profileService
    }
    
    func updateProfile() {
        isLoading = true
        profileService.getProfile { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let body):
                self.profile = body
            case .failure(let error):
                print("Ошибка получения профиля: \(error)")
            }
            isLoading = false
        }
    }
    
    func provideAvatarURL() -> URL? {
        let url = URL(string: profile.avatar)
        return url
    }
    
    func provideWebsiteURL() -> URL? {
        let url = URL(string: profile.website)
        return url
    }
}

//MARK: - ProfileEditingDelegate
extension ProfileViewModel: ProfileEditingDelegate {
    func updateProfileFields() {
        updateProfile()
    }
}
