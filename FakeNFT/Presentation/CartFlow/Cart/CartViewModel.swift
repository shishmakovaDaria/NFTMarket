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
    private (set) var summaryInfo: SummaryInfo = SummaryInfo(countNFT: 0, price: 0)
    
    @Observable
    private (set) var isCartEmpty: Bool = true
  
    //   MARK: - Methods
    func startObserve() {
        observeNFT()
        observeSummaryInfo()
        checkIsCartEmpty()
    }
    
    
    private func observeNFT() {
        nfts = mockNFT
    }
    
    private func observeSummaryInfo() {
        summaryInfo.countNFT = nfts.count
        summaryInfo.price = nfts.reduce(0.0) { $0 + $1.price }
    }
    
    
    
    private func checkIsCartEmpty() {
        if nfts.isEmpty {
            isCartEmpty = true
        }
    }
    
}


// for mock data

struct NFTModel {
    let createdAt: String
    let name: String
    let images: UIImage
    let rating: Int
    let description: String
    let price: Float
    let author: String
    let id: String
}


let mockNFT: [NFTModel] = [
      NFTModel(createdAt: "",
               name: "one nft",
               images: UIImage.bitcoin!,
               rating: 4,
               description: "this is fake",
               price: 1.22,
               author: "Geralt",
               id: "1"
              ),
      NFTModel(createdAt: "",
               name: "two nft",
               images: UIImage.bitcoin!,
               rating: 1,
               description: "this is fake",
               price: 6.22,
               author: "Geralt",
               id: "2"
              ),
      NFTModel(createdAt: "",
               name: "three nft",
               images: UIImage.bitcoin!,
               rating: 0,
               description: "this is fake",
               price: 0.22,
               author: "Geralt",
               id: "3"
              ),
      NFTModel(createdAt: "",
               name: "four nft",
               images: UIImage.bitcoin!,
               rating: 4,
               description: "this is fake",
               price: 11.02,
               author: "Geralt",
               id: "4"
              ),
      NFTModel(createdAt: "",
               name: "five nft",
               images: UIImage.bitcoin!,
               rating: 5,
               description: "this is fake",
               price: 3.67,
               author: "Geralt",
               id: "5"
              ),
      NFTModel(createdAt: "",
               name: "six nft",
               images: UIImage.bitcoin!,
               rating: 2,
               description: "this is fake",
               price: 1.22,
               author: "Geralt",
               id: "6"
              ),
      NFTModel(createdAt: "",
               name: "seven nft",
               images: UIImage.bitcoin!,
               rating: 4,
               description: "this is fake",
               price: 7.77,
               author: "Geralt",
               id: "7"
              ),
]

