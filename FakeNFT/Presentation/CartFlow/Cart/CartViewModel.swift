//
//  CartViewModel.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 01.08.2023.
//

import UIKit

struct CartCellModel {
    let image: UIImage
    let name: String
    let rating: Int
    let price: Double
}

struct SummaryInfo {
    var countNFT: Int
    var price: Float
}

final class CartViewModel {
    // MARK: - Observables
    @Observable
    private (set) var nfts: [NFTModel] = []
    
    @Observable
    private (set) var isCartEmpty: Bool = true
    
    @Observable
    private (set) var isLoaded: Bool = false
    
    
    // MARK: - Properties
    private let cartService: CartService
    private let nftService: NFTService
    
    var summaryInfo: SummaryInfo {
        let price = nfts.reduce(0.0) { $0 + $1.price }
        return SummaryInfo(countNFT: nfts.count, price: price)
    }
    
    var order: [String] = []
    
    
    // MARK: - LifeCycle
    init(cartService: CartService = CartService(), nftService: NFTService = NFTService()) {
        self.cartService = cartService
        self.nftService = nftService
        getOrder()
    }
    
    
    //   MARK: - Methods
    func startObserve() {
        checkIsCartEmpty()
        observeNFT()
    }
    
    func getOrder() {
        isLoaded = false
        cartService.getOrder { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let order):
                    print("\(order.count) order enter on viewModel")
                    self.order = order
                    print("\(self.order.count) order put on viewModel")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        isLoaded = true
    }
    
    private func observeNFT() {
        isLoaded = false
        if order.isEmpty {
            isCartEmpty = true
            isLoaded = true
        } else {
            order.forEach {
                nfts = []
                nftService.getNFT(with: $0) { [weak self] result in
                    guard let self else { return }
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let nfts):
                            self.nfts.append(nfts)
                            print("\(self.nfts.count) on viewModel")
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
        isLoaded = true
    }
    
    private func checkIsCartEmpty() {
        if order.isEmpty {
            isCartEmpty = true
        } else {
            isCartEmpty = false
        }
    }
    
    func clearCart() {
        order = []
        nfts = []
        isCartEmpty = true
    }
    
}

extension CartViewModel: ViewModelProtocol {
    func sort(param: Sort) {
        switch param {
        case .price:
            nfts = nfts.sorted(by: {$0.price > $1.price} )
        case .rating:
            nfts = nfts.sorted(by: {$0.rating > $1.rating} )
        case .name:
            nfts = nfts.sorted(by: {$0.name < $1.name} )
        case .NFTCount:
            break
        case .NFTName:
            break
        }
    }
}
