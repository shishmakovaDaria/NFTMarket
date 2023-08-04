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
    private (set) var currencies: [CurrencyModel] = []
    
    
    //   MARK: - Methods
    func startObserve() {
        observeCurrencises()
        
    }
    
    private func observeCurrencises() {
        currencies = mockCurrencies
    }
}



// mock Сurrencies

struct CurrencyModel {
    let logo: UIImage
    let title: String
    let name: String
    let id: Int
}

let mockCurrencies: [CurrencyModel] = [
    CurrencyModel(logo: UIImage.Icons.bitcoin!, title: "BTC", name: "Bitcoin", id: 1),
    CurrencyModel(logo: UIImage.Icons.ethereum!, title: "ETH", name: "Ethereum", id: 2),
    CurrencyModel(logo: UIImage.Icons.solana!, title: "SOL", name: "Solana", id: 3),
    CurrencyModel(logo: UIImage.Icons.apeCoin!, title: "APE", name: "ApeCoin", id: 4),
    CurrencyModel(logo: UIImage.Icons.dogecoin!, title: "DOGE", name: "Dogecoin", id: 5),
    CurrencyModel(logo: UIImage.Icons.shibaInu!, title: "SHIB", name: "ShibaInu", id: 6),
    CurrencyModel(logo: UIImage.Icons.tether!, title: "USDT", name: "Tether", id: 7),
    CurrencyModel(logo: UIImage.Icons.cardano!, title: "ADA", name: "Cardano", id: 8),
]

