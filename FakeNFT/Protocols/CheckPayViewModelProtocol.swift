//
//  CheckPayViewModelProtocol.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 18.08.2023.
//

import Foundation


protocol CheckPayViewModelProtocol {
    var currencies: [CurrencyModel] { get }
    var isLoading: Bool { get }
    var paymentStatus: PaymentStatus { get }
    
    var currenciesObservable: Observable<[CurrencyModel]> { get }
    var isLoadingObservable: Observable<Bool> { get }
    var paymentStatusObservable: Observable<PaymentStatus> { get }
    
    func startObserve()
    func selectCurrency(with id: String)
    func performPayment()
}
