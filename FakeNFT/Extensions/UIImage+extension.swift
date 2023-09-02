//
//  UIImage+extension.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 29.07.2023.
//

import UIKit

extension UIImage {

    enum Icons {
        // TabBar Icons
        static let profileTab = UIImage(systemName: "person.crop.circle.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 15))
        static let catalogueTab = UIImage(systemName: "rectangle.stack.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 15))
        static let cartTab = UIImage(named: "cartTab")
        static let statisticsTab = UIImage(systemName: "flag.2.crossed.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 15))
        



        static let apeCoin = UIImage(named: "ApeCoin")
        static let bitcoin = UIImage(named: "Bitcoin")
        static let cardano = UIImage(named: "Cardano")
        static let dogecoin = UIImage(named: "Dogecoin")
        static let ethereum = UIImage(named: "Ethereum")
        static let shibaInu = UIImage(named: "ShibaInu")
        static let solana = UIImage(named: "Solana")
        static let tether = UIImage(named: "Tether")
        

        // Basic
        static let close = UIImage(named: "close")
        static let edit = UIImage(named: "edit")
        static let sort = UIImage(named: "sort")
        static let fiveStarRating = UIImage(named: "fiveStarRating")
        static let fourStarRating = UIImage(named: "fourStarRating")
        static let oneStarRating = UIImage(named: "oneStarRating")
        static let threeStarRating = UIImage(named: "threeStarRating")
        static let twoStarRating = UIImage(named: "twoStarRating")
        static let zeroStarRating = UIImage(named: "zeroStarRating")
        static let addToCart = UIImage(named: "addToCart")
        static let deleteFromCart = UIImage(named: "deleteFromCart")
        static let backward = UIImage(systemName: "chevron.backward")
        static let forward = UIImage(systemName: "chevron.forward")
        static let heartFill = UIImage(systemName: "suit.heart.fill")
    }
    
    enum Crypto {
        static let apeCoin = UIImage(named: "apeCoin")
        static let bitcoin = UIImage(named: "bitcoin")
        static let cardano = UIImage(named: "cardano")
        static let dogecoin = UIImage(named: "dogecoin")
        static let ethereum = UIImage(named: "ethereum")
        static let shibaInu = UIImage(named: "shibaInu")
        static let solana = UIImage(named: "solana")
        static let tether = UIImage(named: "tether")
    }
    
    enum Images {
        static let failurePayImage = UIImage(named: "failurePayImage")
        static let successPayImage = UIImage(named: "successPayImage")
    }
}
