//
//  PayViewDelegate.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 05.08.2023.
//

import Foundation

protocol PayViewDelegate: AnyObject {
    func didTapPayButton()
    func didTapUserAgreementLink()
}
