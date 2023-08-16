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
    
    @Observable
    private (set) var isLoading: Bool = true
    
    @Observable
    private (set) var paymentStatus: Bool = false
    
    // MARK: - Properties
    
    private let currencyService: CurrencyService
    
    init(currencyService: CurrencyService = CurrencyService()) {
        self.currencyService = currencyService
    }
    
    //   MARK: - Methods
    
    func startObserve() {
        observeCurrencises()
    }
    
    private func observeCurrencises() {
        isLoading = true
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
        isLoading = false
    }
    
    func selectCurrency(with id: String) {
        self.selectedCurrency = currencies.first(where: { $0.id == id } )
        print("\(String(describing: selectedCurrency?.name)) was selected")
    }
}

