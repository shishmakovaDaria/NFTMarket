//
//  ProfileViewModel.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 01.08.2023.
//

import Foundation

final class ProfileViewModel {
    
    @Observable
    private(set) var profileName = ""
    
    @Observable
    private(set) var profileDescription = ""
    
    @Observable
    private(set) var profileWebsite = ""
    
    @Observable
    private(set) var profileAvatarURL = URL(string: "")
    
    private let dataProvider: DataProvider
    private var profile: ProfileModel?
    
    convenience init() {
        self.init(dataProvider: DataProvider())
    }

    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
        updateProfile()
        profileName = profile?.name ?? ""
        profileDescription = profile?.description ?? ""
        profileWebsite = profile?.website ?? ""
        guard let avatarURL = profile?.avatar,
              let url = URL(string: avatarURL)
        else { return }
        profileAvatarURL = url
    }
    
    func updateProfile() {
        profile = dataProvider.getUserInfo()
    }
    
    func provideTableHeaders() -> [String] {
        let tableHeaders: [String] = [
            "\("My NFTs".localized()) (\(profile?.nfts.count ?? 0))",
            "\("Favorite NFTs".localized()) (\(profile?.likes.count ?? 0))",
            "About the developer".localized()
        ]
        return tableHeaders
    }
    
    func provideWebsiteURL() -> URL? {
        let url = URL(string: profile?.website ?? "")
        return url
    }
}
