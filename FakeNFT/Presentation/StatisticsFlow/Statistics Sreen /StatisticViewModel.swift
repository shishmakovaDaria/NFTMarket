//
//  StatisticViewModel.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 02.08.2023.
//

import UIKit

final class StatisticViewModel: StatisticViewModelProtocol {
    
    // MARK: - Observables
    @Observable
    private (set) var users: [UserModel] = []
    var usersObservable: Observable<[UserModel]> {$users}
    @Observable
    private (set) var isLoading = false
    var isLoadingObservable: Observable<Bool> {$isLoading}
    
    //MARK: - Properties
    
    private (set) var sortConfig: String?
    
    //MARK: - Servicies
    let usersService: UsersServiceProtocol
    
    //MARK: - LifeCycle
    init(userService: UsersServiceProtocol = UsersService()) {
        self.usersService = userService
    }
    
    // MARK: - Methods
    func startObserve() {
        startSort()
        users.isEmpty ? getUsers() : ()
    }
    
    private func getUsers() {
        isLoading = true
        usersService.getUsers {result in
            switch result {
            case let .success(users):
                self.users = users
                self.startSort()
                self.isLoading = false
            case let .failure(error):
                print("Ошибка получения списка рейтинга юзеров: \(error)")
                self.isLoading = false
            }
        }
    }
    
    private func startSort() {
        sortConfig =  UserDefaults.standard.string(forKey: "sortConfig")
        guard let sortConfig else { return }
        sortConfig == "rating" ? sort(param: .rating) : sort(param: .name)
    }
}

extension StatisticViewModel: Sortable {
    
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
