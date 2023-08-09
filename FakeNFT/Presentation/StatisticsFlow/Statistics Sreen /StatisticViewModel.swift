//
//  StatisticViewModel.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 02.08.2023.
//

import UIKit

final class StatisticViewModel {
    // MARK: - Observables
    @Observable
    private (set) var users: [UserModel] = []
    
    //MARK: - Servicies
    let usersService = UsersService()
    
    // MARK: - Methods
    func startObserve() {
        getUsers()
    }

    
    private func getUsers() {
        usersService.getUsers {result in
            switch result {
            case let .success(users):
                self.users = users
            case let .failure(error):
                print("Ошибка получения списка рейтинга юзеров: \(error)")
                
            }
        }
    }
}

extension StatisticViewModel: ViewModelProtocol {
    func sort(param: Sort) {
        if param == .rating {
            users.sort { Int($0.rating)! > Int($1.rating)!}
        } else if param == .name {
            users.sort { $0.name < $1.name }
        }
    }
}
