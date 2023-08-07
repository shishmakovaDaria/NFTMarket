//
//  ProfileViewModel.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 01.08.2023.
//

import Foundation

final class ProfileViewModel {
    
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
    
    private let profileService = ProfileService()
    
    func updateProfile() {
        profileService.getProfile { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let body):
                self.profile = body
            case .failure(let error):
                print("Ошибка получения профиля: \(error)")
            }
        }
    }
    
    func provideTableHeaders() -> [String] {
        let tableHeaders: [String] = [
            "\("My NFTs".localized()) (\(profile.nfts.count))",
            "\("Favorite NFTs".localized()) (\(profile.likes.count))",
            "About the developer".localized()
        ]
        return tableHeaders
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


extension ProfileViewModel: ProfileEditingDelegate {
    // доделать
}
