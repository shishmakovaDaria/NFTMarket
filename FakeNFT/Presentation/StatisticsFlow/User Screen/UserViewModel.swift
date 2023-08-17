//
//  UserViewModel.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 03.08.2023.
//

import UIKit

final class UserViewModel: UserViewModelProtocol {
    // MARK: - Observables
    @Observable
    private (set) var user: UserModel
    var userObservable: Observable<UserModel> { $user }
    //MARK: - LifeCycle
    
    init(user: UserModel) {
        self.user = user
    }
    
    // MARK: - Methods
}
