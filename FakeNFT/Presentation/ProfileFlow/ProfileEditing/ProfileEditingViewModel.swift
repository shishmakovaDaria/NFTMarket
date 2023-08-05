//
//  ProfileEditingViewModel.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 03.08.2023.
//

import Foundation

protocol ProfileEditingDelegate: AnyObject {
    func updateProfile()
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
    
    private let dataProvider: DataProvider
    var delegate: ProfileEditingDelegate?
    
    convenience init() {
        self.init(dataProvider: DataProvider())
    }

    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    func updateProfile(profileToSet: ProfileModel) {
        profile = profileToSet
    }
    
    func changeProfileName(nameToSet: String) {
        dataProvider.changeProfileName(nameToSet: nameToSet)
    }
    
    func viewDismiss() {
        delegate?.updateProfile()
    }
}
