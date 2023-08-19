//
//  CheckPayViewModel.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 04.08.2023.
//

import UIKit

enum PaymentStatus {
    case notPay
    case success
    case failure
}

final class CheckPayViewModel: CheckPayViewModelProtocol {
    
    // MARK: - Observables
    
    @Observable
    private (set) var currencies: [CurrencyModel] = []
    
    @Observable
    private (set) var isLoading: Bool = true
    
    @Observable
    private (set) var paymentStatus: PaymentStatus = .notPay
    
    // MARK: - Properties
    
    private let currencyService: CurrencyServiceProtocol
    private let cartService: CartServiceProtocol
    private var selectedCurrency: CurrencyModel?
    
    var currenciesObservable: Observable<[CurrencyModel]> { $currencies }
    var isLoadingObservable: Observable<Bool> { $isLoading }
    var paymentStatusObservable: Observable<PaymentStatus> { $paymentStatus }
    
    init(currencyService: CurrencyServiceProtocol = CurrencyService(),
         cartService: CartServiceProtocol = CartService()
    ) {
        self.currencyService = currencyService
        self.cartService = cartService
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
                    self.isLoading = false
                    print(error.localizedDescription)
                }
            }
        }
        isLoading = false
    }
    
    private func clearOrder() {
        isLoading = true
        cartService.updateOrder(updatedOrder: []) { result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let order):
                        if order.nfts.isEmpty { print("order is empty")}
                    case .failure(let error):
                        self.paymentStatus = .failure
                        self.isLoading = false
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
    }
    
    func performPayment() {
        guard let id = selectedCurrency?.id else { return }
        isLoading = true
        currencyService.performPaymentOrder(with: id) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    if result.success == true {
                        self.paymentStatus = .success
                        self.clearOrder()
                    } else {
                        self.paymentStatus = .failure
                        self.selectedCurrency = nil
                    }
                case .failure(let error):
                    self.paymentStatus = .failure
                    self.isLoading = false
                    print(error.localizedDescription)
                }
            }
        }
        isLoading = false
    }
    
}

