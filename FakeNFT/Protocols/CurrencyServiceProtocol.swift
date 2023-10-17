//
//  CurrencyServiceProtocol.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 16.08.2023.
//

import Foundation

protocol CurrencyServiceProtocol {
    var networkClient: NetworkClient { get }
    func getCurrencies(completion: @escaping (Result<[CurrencyModel], Error>) -> Void)
    func performPaymentOrder(with currencyID: String, completion: @escaping (Result<PaymentCurrencyModel, Error>) -> Void)
}
