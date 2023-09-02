//
//  StatisticViewModelProtocol.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 17.08.2023.
//

import Foundation

protocol StatisticViewModelProtocol {
    var users: [UserModel] { get }
    var usersObservable: Observable<[UserModel]> { get }
    var isLoading: Bool { get }
    var isLoadingObservable: Observable<Bool> { get }
    func startObserve()
    func getCellModel(at indexPath: IndexPath) -> StatisticCellModel
}
