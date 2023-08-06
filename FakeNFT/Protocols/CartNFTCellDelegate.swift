//
//  CartNFTCellDelegate.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 03.08.2023.
//

import Foundation

protocol CartNFTCellDelegate: AnyObject {
    func didTapDeleteButton(on nft: mockNFTModel)
}
