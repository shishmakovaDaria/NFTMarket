//
//  DeleteFromCartViewControllerDelegate.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 10.08.2023.
//

import Foundation

protocol DeleteFromCartViewControllerDelegate: AnyObject {
    func didTapReturnButton()
    func didTapDeleteButton(_ model: NFTModel)
}
