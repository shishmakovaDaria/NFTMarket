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
}

enum SortForScreen {
    case catalogue
    case profile
    case cart
    case statistic
}


extension UIViewController {
    
    func showAlertSort(viewModel: ViewModelProtocol, valueSort: SortForScreen) {
        
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
        
        let closeAction = UIAlertAction(title: "Close".localized(), style: .cancel)
        
        
        switch valueSort {
        case .catalogue:
            alert.addAction(sortByNameAction)
            alert.addAction(sortByNFTCountAction)
        case .profile:
            alert.addAction(sortByPriceAction)
            alert.addAction(sortByRatingAction)
            alert.addAction(sortByNameAction)
        case .cart:
            alert.addAction(sortByPriceAction)
            alert.addAction(sortByRatingAction)
            alert.addAction(sortByNameAction)
        case .statistic:
            alert.addAction(sortByNameAction)
            alert.addAction(sortByNFTCountAction)
        }
       
        alert.addAction(closeAction)
        
        present(alert, animated: true)
    }
}

