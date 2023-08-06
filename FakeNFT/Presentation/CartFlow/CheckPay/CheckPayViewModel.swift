//
//  CheckPayViewModel.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 04.08.2023.
//

import UIKit

final class CheckPayViewModel {
    
    // MARK: - Observables
    
    @Observable
    private (set) var currencies: [MockCurrencyModel] = []
    
    
    //   MARK: - Methods
    func startObserve() {
        observeCurrencises()
        
    }
    
    private func observeCurrencises() {
        currencies = mockCurrencies
    }
}



// mock Сurrencies

struct MockCurrencyModel {
    let logo: UIImage
    let title: String
    let name: String
    let id: Int
}

let mockCurrencies: [MockCurrencyModel] = [
    MockCurrencyModel(logo: UIImage.Icons.bitcoin!, title: "BTC", name: "Bitcoin", id: 1),
    MockCurrencyModel(logo: UIImage.Icons.ethereum!, title: "ETH", name: "Ethereum", id: 2),
    MockCurrencyModel(logo: UIImage.Icons.solana!, title: "SOL", name: "Solana", id: 3),
    MockCurrencyModel(logo: UIImage.Icons.apeCoin!, title: "APE", name: "ApeCoin", id: 4),
    MockCurrencyModel(logo: UIImage.Icons.dogecoin!, title: "DOGE", name: "Dogecoin", id: 5),
    MockCurrencyModel(logo: UIImage.Icons.shibaInu!, title: "SHIB", name: "ShibaInu", id: 6),
    MockCurrencyModel(logo: UIImage.Icons.tether!, title: "USDT", name: "Tether", id: 7),
    MockCurrencyModel(logo: UIImage.Icons.cardano!, title: "ADA", name: "Cardano", id: 8),
]

