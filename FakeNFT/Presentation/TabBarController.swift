//
//  TabBarController.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 30.07.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tabBar.backgroundColor = .whiteDay
        UITabBar.appearance().barTintColor = .systemBackground
        setupTabBarItems()
    }
    
    private func createNavController(
        for rootViewController: UIViewController,
        title: String,
        image: UIImage
    ) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = false
        return navController
    }
    
    private func setupTabBarItems() {
        viewControllers = [
            createNavController(for: ProfileViewController(),
                                title: "Profile".localized(),
                                image: UIImage.Icons.profileTab ?? UIImage()),
            
            createNavController(for: CatalogViewController(),
                                title: "Catalog".localized(),
                                image: .Icons.catalogTab ?? UIImage()),
            
            createNavController(for: CartViewController(),
                                title: "Cart".localized(),
                                image: .Icons.cartTab ?? UIImage()),
            
            createNavController(for: StatisticViewController(),
                                title: "Statistics".localized(),
                                image: .Icons.statisticsTab ?? UIImage())
        ]
        tabBar.unselectedItemTintColor = .blackDay
    }
}
