//
//  DataProvider.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 05.08.2023.
//

import Foundation

final class DataProvider {
    
    private func getNFTss() -> [String] {
        return []
    }
}

protocol CollectionDataProvider {
    func getNfts()
}

extension DataProvider: CollectionDataProvider {
    func getNfts() {
        self.getNFTss()
    }
}
