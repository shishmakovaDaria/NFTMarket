//
//  ProfileEditingViewModel.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 03.08.2023.
//

import Foundation

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
    
    private let dataProvider: DataProvider
    
    convenience init() {
        self.init(dataProvider: DataProvider())
    }

    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    func updateProfile(profileToSet: ProfileModel) {
        profile = profileToSet
    }
}
