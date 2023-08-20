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
    var usersObservable: Observable<[UserModel]> { $users }
    @Observable
    private (set) var isLoading = false
    var isLoadingObservable: Observable<Bool> { $isLoading }
     
    //MARK: - Servicies
    private let usersService: UsersServiceProtocol
    private let sortingSaveService: SortingSaveServiceProtocol
    
    //MARK: - LifeCycle
    init(userService: UsersServiceProtocol = UsersService(), sortingSaveService: SortingSaveServiceProtocol = SortingSaveService(screen: .statistic)) {
        self.usersService = userService
        self.sortingSaveService = sortingSaveService
    }
    
    // MARK: - Methods
    func startObserve() {
        sort(param: sortingSaveService.savedSorting)
        users.isEmpty ? getUsers() : ()
    }
    
    func getCellModel(at indexPath: IndexPath) -> StatisticCellModel {
        let userModel = users[indexPath.row]
        let cellModel = StatisticCellModel(name: userModel.name,
                                           avatar: userModel.avatar,
                                           rating: userModel.rating,
                                           indexNumber: indexPath.row + 1)
        return cellModel
    }
    
    private func getUsers() {
        isLoading = true
        usersService.getUsers {result in
            switch result {
            case let .success(users):
                self.users = users
                self.sort(param: self.sortingSaveService.savedSorting)
                self.isLoading = false
            case let .failure(error):
                print(error.localizedDescription)
                self.isLoading = false
            }
        }
    }
}

extension StatisticViewModel: Sortable {
    func sort(param: Sort) {
        sortingSaveService.saveSorting(param: param)
        if param == .rating {
            users.sort { if let ratingOne = Int($0.rating), let ratingTwo = Int($1.rating) {
                return ratingOne > ratingTwo
            }
                return false
            }
        } else if param == .name {
            users.sort { $0.name < $1.name }
        }
    }
}
