//
//  String+extension.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 31.07.2023.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self)
    }
}
