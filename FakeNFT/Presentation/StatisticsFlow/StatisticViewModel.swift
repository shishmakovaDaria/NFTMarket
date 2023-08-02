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
    let count: Int
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

let mockStatsCells: [StatisticCellModel] = [
    StatisticCellModel(name: "apeCoin", avatar: .Icons.apeCoin!, count: 1),
    StatisticCellModel(name: "bitcoin", avatar: .Icons.bitcoin!, count: 2),
    StatisticCellModel(name: "cardano", avatar: .Icons.cardano!, count: 3),
    StatisticCellModel(name: "dogecoin", avatar: .Icons.dogecoin!, count: 4),
    StatisticCellModel(name: "apeCoin", avatar: .Icons.apeCoin!, count: 5),
    StatisticCellModel(name: "ethereum", avatar: .Icons.ethereum!, count: 6),
    StatisticCellModel(name: "shibaInu", avatar: .Icons.shibaInu!, count: 7),
    StatisticCellModel(name: "solana", avatar: .Icons.solana!, count: 8),
    StatisticCellModel(name: "tether", avatar: .Icons.tether!, count: 9),
]
