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

final class CartViewModel: CartViewModelProtocol {
    
    // MARK: - Observables
    
    @Observable
    private (set) var nfts: [NFTModel] = []
    
    @Observable
    private (set) var isCartEmpty: Bool = true
    
    @Observable
    private (set) var isLoading: Bool = true
    
    // MARK: - Properties
    
    private let cartService: CartServiceProtocol
    private let nftService: NFTServiceProtocol
    private let sortingSaveService: SortingSaveServiceProtocol
    
    var nftsObservable: Observable<[NFTModel]> { $nfts }
    var isCartEmptyObservable: Observable<Bool> { $isCartEmpty }
    var isLoadingObservable: Observable<Bool> { $isLoading }
    
    var summaryInfo: SummaryInfo {
        let price = nfts.reduce(0.0) { $0 + $1.price }
        return SummaryInfo(countNFT: nfts.count, price: price)
    }
     var order: [String] = [] {
        didSet {
            self.nfts = []
            observeNFT()
        }
    }
    
    // MARK: - LifeCycle
    
    init(
        cartService: CartServiceProtocol = CartService(),
        nftService: NFTServiceProtocol = NFTService(),
        sortingSaveService: SortingSaveServiceProtocol = SortingSaveService(screen: .cart)
    ) {
        self.cartService = cartService
        self.nftService = nftService
        self.sortingSaveService = sortingSaveService
        getOrder()
    }
    
    //   MARK: - Methods
    
    private func getOrder() {
        isLoading = true
        nfts = []
        cartService.getOrder { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                    case .success(let order):
                        self.order = order
                    case .failure(let error):
                        self.isLoading = false
                        print(error.localizedDescription)
                }
            }
        }
    }
    
    private func observeNFT() {
        isLoading = true
        if order.isEmpty {
            isCartEmpty = true
            isLoading = false
        } else {
            order.forEach {
                nftService.getNFT(with: $0) { [weak self] result in
                    guard let self else { return }
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let nfts):
                            self.nfts.append(nfts)
                            self.sort(param: self.sortingSaveService.savedSorting)
                        case .failure(let error):
                            self.isLoading = false
                            print(error.localizedDescription)
                        }
                    }
                }
            }
            isLoading = false
        }
    }
    
    private func checkIsCartEmpty() {
        if order.isEmpty {
            isCartEmpty = true
        } else {
            isCartEmpty = false
        }
    }
    
    func startObserve() {
        getOrder()
        checkIsCartEmpty()
    }
    
    func deleteNFT(_ nft: NFTModel, completion: @escaping () -> Void) {
        isLoading = true
        let updatedOrder = order.filter { $0 != nft.id }
        cartService.updateOrder(updatedOrder: updatedOrder) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                    case .success(let order):
                        self.order = order.nfts
                        self.nfts = self.nfts.filter { updatedOrder.contains($0.id) }
                        completion()
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
        }
        isLoading = false
    }
    
}

// MARK: - Sortable

extension CartViewModel: Sortable {
    func sort(param: Sort) {
        sortingSaveService.saveSorting(param: param)
        switch param {
            case .price:
                nfts = nfts.sorted(by: {$0.price > $1.price} )
            case .rating:
                nfts = nfts.sorted(by: {$0.rating > $1.rating} )
            case .NFTName:
                nfts = nfts.sorted(by: {$0.name < $1.name} )
            case .NFTCount:
                break
            case .name:
                break
        }
    }
}
