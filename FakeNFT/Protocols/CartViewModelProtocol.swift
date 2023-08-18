//
//  CartViewModelProtocol.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 18.08.2023.
//

import Foundation


protocol CartViewModelProtocol {
    var nfts: [NFTModel] { get }
    var isCartEmpty: Bool { get }
    var isLoading: Bool { get }
    var summaryInfo: SummaryInfo { get }
    
    var nftsObservable: Observable<[NFTModel]> { get }
    var isCartEmptyObservable: Observable<Bool> { get }
    var isLoadingObservable: Observable<Bool> { get }
    
    func deleteNFT(_ nft: NFTModel, completion: @escaping () -> Void)
    func startObserve()
}
