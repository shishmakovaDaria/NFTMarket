//
//  UserViewModelProtocol.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 17.08.2023.
//

import Foundation

protocol UserViewModelProtocol {
    var user: UserModel { get }
    var userObservable: Observable<UserModel>  { get }
    init(user: UserModel)
}
