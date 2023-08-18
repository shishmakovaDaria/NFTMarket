//
//  SortingSaveServiceProtocol.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 17.08.2023.
//

import Foundation

protocol SortingSaveServiceProtocol {
    var savedSorting: Sort { get }
    func saveSorting(param: Sort)
}
