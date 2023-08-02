//
//  TabBarController.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 30.07.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    private let cartViewModel = CartViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tabBar.backgroundColor = .whiteDay
        UITabBar.appearance().barTintColor = .systemBackground
        setupVCs()
        
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                                    title: String,
                                                    image: UIImage) -> UIViewController {
          let navController = UINavigationController(rootViewController: rootViewController)
          navController.tabBarItem.title = title
          navController.tabBarItem.image = image
          navController.navigationBar.prefersLargeTitles = true
          return navController
    }
    
    
    fileprivate func setupVCs() {
        viewControllers = [
            createNavController(for: ProfileViewController(), title: "Профиль", image: .profileTab!),
            createNavController(for: CatalogViewController(), title: "Каталог", image: .catalogueTab!),
            createNavController(for: CartViewController(viewModel: cartViewModel), title: "Корзина", image: .cartTab!),
            createNavController(for: StatisticViewController(), title: "Статистика", image: .statisticsTab!)
        ]
        tabBar.unselectedItemTintColor = .blackDay
    }
    
    
}
