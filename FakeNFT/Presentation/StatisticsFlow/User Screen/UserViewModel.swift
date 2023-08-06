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
    
    // MARK: - Methods
    func startObserve(indexPath: IndexPath) {
        getUser(indexPath)
    }
    
    private func getUser(_ indexPath: IndexPath) {
        user = mockUsers[indexPath.row]
    }
}
