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
    
    @Observable
    private(set) var nftCount = 0
    
    @Observable
    private(set) var favoriteNftCount = 0
    
    private let dataProvider: DataProvider
    private var profile: ProfileModel?
    
    convenience init() {
        self.init(dataProvider: DataProvider())
    }

    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
        updateProfile()
    }
    
    func updateProfile() {
        profile = dataProvider.getUserInfo()
        updateObservable()
    }
    
    private func updateObservable() {
        profileName = profile?.name ?? ""
        profileDescription = profile?.description ?? ""
        profileWebsite = profile?.website ?? ""
        guard let avatarURL = profile?.avatar,
              let url = URL(string: avatarURL)
        else { return }
        profileAvatarURL = url
        nftCount = profile?.nfts.count ?? 0
        favoriteNftCount = profile?.likes.count ?? 0
    }
    
    func provideTableHeaders() -> [String] {
        let tableHeaders: [String] = [
            "\("My NFTs".localized()) (\(nftCount))",
            "\("Favorite NFTs".localized()) (\(favoriteNftCount))",
            "About the developer".localized()
        ]
        return tableHeaders
    }
    
    func provideWebsiteURL() -> URL? {
        let url = URL(string: profile?.website ?? "")
        return url
    }
}
