//
//  StatisticViewModel.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 02.08.2023.
//

import UIKit

struct StatisticCellModel {
    let name: String
    let avatar: UIImage
    let rating: Int
}

final class StatisticViewModel {
    // MARK: - Observables
    @Observable
    private (set) var staticsCellModels: [StatisticCellModel] = []
    
    // MARK: - Methods
    func startObserve() {
        getStats()
    }
    
    private func getStats() {
        staticsCellModels = mockStatsCells
    }
}

extension StatisticViewModel: ViewModelProtocol {
    func sort(param: Sort) {
        if param == .rating {
            staticsCellModels.sort { $0.rating < $1.rating}
        } else if param == .name {
            staticsCellModels.sort { $0.name < $1.name }
        }
    }
    
    
}

let mockStatsCells: [StatisticCellModel] = [
    StatisticCellModel(name: "apeCoin", avatar: .Icons.apeCoin!, rating: 1),
    StatisticCellModel(name: "bitcoin", avatar: .Icons.bitcoin!, rating: 2),
    StatisticCellModel(name: "cardano", avatar: .Icons.cardano!, rating: 3),
    StatisticCellModel(name: "dogecoin", avatar: .Icons.dogecoin!, rating: 4),
    StatisticCellModel(name: "apeCoin", avatar: .Icons.apeCoin!, rating: 5),
    StatisticCellModel(name: "ethereum", avatar: .Icons.ethereum!, rating: 6),
    StatisticCellModel(name: "shibaInu", avatar: .Icons.shibaInu!, rating: 7),
    StatisticCellModel(name: "solana", avatar: .Icons.solana!, rating: 8),
    StatisticCellModel(name: "tether", avatar: .Icons.tether!, rating: 9),
]
