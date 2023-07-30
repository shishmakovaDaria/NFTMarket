//
//  ReuseIdentifier.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 30.07.2023.
//

import Foundation

protocol ReuseIdentifier { }

extension ReuseIdentifier {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
