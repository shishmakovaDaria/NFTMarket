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
    
    private let dataProvider: DataProvider
    
    convenience init() {
        self.init(dataProvider: DataProvider())
    }

    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
        //updateProfile()
    }
    
    func updateProfile() {
        profile = dataProvider.getUserInfo()
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
