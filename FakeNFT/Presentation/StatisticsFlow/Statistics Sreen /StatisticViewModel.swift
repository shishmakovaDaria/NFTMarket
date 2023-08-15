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
    
    //MARK: - Properties
    
    private var sortConfig: String? = UserDefaults.standard.string(forKey: "sortConfig")
    
    //MARK: - Servicies
    let usersService = UsersService()
    
    // MARK: - Methods
    func startObserve() {
        startSort()
        users.isEmpty ? getUsers() : ()
    }
    
    private func getUsers() {
        usersService.getUsers {result in
            switch result {
            case let .success(users):
                self.users = users
                self.startSort()
            case let .failure(error):
                print("Ошибка получения списка рейтинга юзеров: \(error)")
            }
        }
    }
    
    private func startSort() {
        guard let sortConfig else { return }
        sortConfig == "rating" ? sort(param: .rating) : sort(param: .name)
    }
}

extension StatisticViewModel: ViewModelProtocol {
    func sort(param: Sort) {
        if param == .rating {
            UserDefaults.standard.set("rating", forKey: "sortConfig")
            users.sort { Int($0.rating)! > Int($1.rating)!}
        } else if param == .name {
            UserDefaults.standard.set("name", forKey: "sortConfig")
            users.sort { $0.name < $1.name }
        }
    }
}
