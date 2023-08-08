//
//  CurrencyService.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 08.08.2023.
//

import Foundation

struct GetCurrenciesRequest: NetworkRequest {
    var endpoint: URL? {
        Constants.endpoint?.appendingPathComponent("/currencies")
    }
}


struct CurrencyService {
    
    let networkClient = DefaultNetworkClient()
    let request = GetCurrenciesRequest()
    
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
}
