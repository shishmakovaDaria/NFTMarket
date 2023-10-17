//
//  ProfileViewModelProtocol.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 17.10.2023.
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
