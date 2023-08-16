//
//  CurrencyService.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 16.08.2023.
//

import Foundation


struct CurrencyService {
    
    let networkClient: NetworkClient
    let request: NetworkRequest
    
    init(
        networkClient: NetworkClient = DefaultNetworkClient(),
        request: NetworkRequest = GetCurrenciesRequest()
    ) {
        self.networkClient = networkClient
        self.request = request
    }
    
    func getCurrencies(completion: @escaping (Result<[CurrencyModel], Error>) -> Void) {
        networkClient.send(request: request, type: [CurrencyModel].self) { result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let currencies):
                    completion(.success(currencies))
                    case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func performPaymentOrder(with currencyID: String, completion: @escaping (Result<PaymentCurrencyModel, Error>) -> Void) {
        let paymentOrderRequest = PaymentOrderRequest(id: currencyID)
        networkClient.send(request: paymentOrderRequest, type: PaymentCurrencyModel.self) { result in
            switch result {
                case .success(let payment):
                completion(.success(payment))
                case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
}
