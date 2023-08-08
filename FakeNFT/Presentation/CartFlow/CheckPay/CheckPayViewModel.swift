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
    
    @Observable
    private (set) var selectedCurrency: CurrencyModel?
    
    
    // MARK: - Properties
    
    private let currencyService = CurrencyService()
    
    //   MARK: - Methods
    func startObserve() {
        observeCurrencises()
        
    }
    
    private func observeCurrencises() {
        currencyService.getCurrencies { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let currencies):
                    self.currencies = currencies
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func selectCurrency(with id: String) {
        self.selectedCurrency = currencies.first(where: { $0.id == id } )
        print("\(String(describing: selectedCurrency?.name)) was selected")
    }
}

