//
//  UserViewModelProtocol.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 17.08.2023.
//

import UIKit

protocol UserViewModelProtocol {
    var user: UserModel { get }
    var userObservable: Observable<UserModel>  { get }
    func updateAvatar(for imageView: UIImageView)
    init(user: UserModel)
}
