//
//  UserViewModel.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 03.08.2023.
//

import UIKit

final class UserViewModel {
    // MARK: - Observables
    @Observable
    private (set) var user: UserModel?
    
    //MARK: - LifeCycle
    
    init(user: UserModel) {
        self.user = user
    }
    
    // MARK: - Methods
}
