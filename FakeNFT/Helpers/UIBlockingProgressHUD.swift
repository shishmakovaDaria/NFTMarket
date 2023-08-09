//
//  File.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 09.08.2023.
//


import UIKit
import ProgressHUD


final class UIBlockingProgressHUD {
    private static var window: UIWindow? {
        return UIApplication.shared.windows.first
    }
    
    static func show() {
        window?.isUserInteractionEnabled = false
        ProgressHUD.show()
    }
    
    static func dismiss() {
        window?.isUserInteractionEnabled = true
        ProgressHUD.dismiss()
    }
}
