//
//  UIViewController+extension.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 03.08.2023.
//

import UIKit

enum Sort {
    case price
    case rating
    case name
    case NFTCount
    case NFTName
}

enum SortForScreen {
    case catalogue
    case profile
    case cart
    case statistic
}


extension UIViewController {
    
    func showAlertSort(viewModel: Sortable, valueSort: SortForScreen) {
        
        let alert = UIAlertController(
            title: nil,
            message: "Sorting".localized(),
            preferredStyle: .actionSheet
        )
        
        let sortByPriceAction = UIAlertAction(title: "By price".localized(), style: .default) { _ in
            viewModel.sort(param: .price)
        }
        
        let sortByRatingAction = UIAlertAction(title: "By rating".localized(), style: .default) { _ in
            viewModel.sort(param: .rating)
        }
        
        let sortByNameAction = UIAlertAction(title: "By name".localized(), style: .default) { _ in
            viewModel.sort(param: .name)
        }
        
        let sortByNFTCountAction = UIAlertAction(title: "By NFT count".localized(), style: .default) { _ in
            viewModel.sort(param: .NFTCount)
        }
        
        let sortByNFTNameAction = UIAlertAction(title: "By NFT name".localized(), style: .default) { _ in
            viewModel.sort(param: .NFTName)
        }
        
        let closeAction = UIAlertAction(title: "Close".localized(), style: .cancel)
        
        switch valueSort {
            case .catalogue:
            alert.addAction(sortByNFTNameAction)
            alert.addAction(sortByNFTCountAction)
            case .profile:
            alert.addAction(sortByPriceAction)
            alert.addAction(sortByRatingAction)
            alert.addAction(sortByNFTNameAction)
            case .cart:
            alert.addAction(sortByPriceAction)
            alert.addAction(sortByRatingAction)
            alert.addAction(sortByNFTNameAction)
            case .statistic:
            alert.addAction(sortByNameAction)
            alert.addAction(sortByRatingAction)
        }
       
        alert.addAction(closeAction)
        
        present(alert, animated: true)
    }
}

