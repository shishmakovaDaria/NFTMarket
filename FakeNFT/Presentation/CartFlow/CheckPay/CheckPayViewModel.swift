//
//  CheckPayViewModel.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 04.08.2023.
//

import UIKit

final class CheckPayViewModel {
    
    enum PaymentStatus {
        case notPay
        case success
        case failure
    }
    
    // MARK: - Observables
    
    @Observable
    private (set) var currencies: [CurrencyModel] = []
    
    @Observable
    private (set) var selectedCurrency: CurrencyModel?
    
    @Observable
    private (set) var isLoading: Bool = true
    
    @Observable
    private (set) var paymentStatus: PaymentStatus = .notPay
    
    // MARK: - Properties
    
    private let currencyService: CurrencyService
    
    init(currencyService: CurrencyService = CurrencyService()) {
        self.currencyService = currencyService
    }
    
    //   MARK: - Methods
    
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
    
    func startObserve() {
        observeCurrencises()
    }
    
    func selectCurrency(with id: String) {
        self.selectedCurrency = currencies.first(where: { $0.id == id } )
        print("\(String(describing: selectedCurrency?.name)) was selected")
    }
    
    func performPayment() {
        guard let id = selectedCurrency?.id else { return }
        
        currencyService.performPaymentOrder(with: id) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    if result.success == true {
                        self.paymentStatus = .success
                        // TO DO: - ADD CLEAR CART METHOD
                    } else {
                        self.paymentStatus = .failure
                    }
                case .failure(let error):
                    self.paymentStatus = .failure
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}

