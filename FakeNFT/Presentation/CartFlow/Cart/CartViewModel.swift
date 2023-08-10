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
    
    var summaryInfo: SummaryInfo {
        let price = nfts.reduce(0.0) { $0 + $1.price }
        return SummaryInfo(countNFT: nfts.count, price: price)
    }
    
    // MARK: - Properties
    private let cartService: CartService
    private let nftService: NFTService
    
    var order: [String] = []
    
    
    // MARK: - LifeCycle
    init(cartService: CartService = CartService(), nftService: NFTService = NFTService()) {
        
        self.cartService = cartService
        self.nftService = nftService
        getOrder()
    }
    
    
    //   MARK: - Methods
    func startObserve() {
        observeNFT()
        checkIsCartEmpty()
    }
    
    func getOrder() {
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
    }
    
    private func observeNFT() {
        if !order.isEmpty {
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
    }
    
    
    
    private func checkIsCartEmpty() {
        if order.isEmpty {
            isCartEmpty = true
        }
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
        }
    }
    
}


// for mock data
//struct mockNFTModel {
//    let createdAt: String
//    let name: String
//    let images: UIImage
//    let rating: Int
//    let description: String
//    let price: Float
//    let author: String
//    let id: String
//}
//
//
//let mockNFT: [mockNFTModel] = [
//    mockNFTModel(createdAt: "",
//               name: "one nft",
//               images: UIImage.Crypto.bitcoin!,
//               rating: 4,
//               description: "this is fake",
//               price: 1.22,
//               author: "Geralt",
//               id: "1"
//              ),
//    mockNFTModel(createdAt: "",
//               name: "two nft",
//               images: UIImage.Crypto.cardano!,
//               rating: 1,
//               description: "this is fake",
//               price: 6.22,
//               author: "Geralt",
//               id: "2"
//              ),
//    mockNFTModel(createdAt: "",
//               name: "three nft",
//               images: UIImage.Crypto.shibaInu!,
//               rating: 0,
//               description: "this is fake",
//               price: 0.22,
//               author: "Geralt",
//               id: "3"
//              ),
//    mockNFTModel(createdAt: "",
//               name: "four nft",
//               images: UIImage.Crypto.ethereum!,
//               rating: 4,
//               description: "this is fake",
//               price: 11.02,
//               author: "Geralt",
//               id: "4"
//              ),
//    mockNFTModel(createdAt: "",
//               name: "five nft",
//               images: UIImage.Crypto.dogecoin!,
//               rating: 5,
//               description: "this is fake",
//               price: 3.67,
//               author: "Geralt",
//               id: "5"
//              ),
//    mockNFTModel(createdAt: "",
//               name: "six nft",
//               images: UIImage.Crypto.tether!,
//               rating: 2,
//               description: "this is fake",
//               price: 1.22,
//               author: "Geralt",
//               id: "6"
//              ),
//    mockNFTModel(createdAt: "",
//               name: "seven nft",
//               images: UIImage.Crypto.solana!,
//               rating: 4,
//               description: "this is fake",
//               price: 7.77,
//               author: "Geralt",
//               id: "7"
//              ),
//]
//
