//
//  TabBarController.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 30.07.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    let catalogueViewModel = CatalogueViewModel()
    let profileViewModel = ProfileViewModel()
    let cartViewModel = CartViewModel()
    let statisticViewModel = StatisticViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tabBar.backgroundColor = .whiteDay
        UITabBar.appearance().barTintColor = .systemBackground
        setupTabBarItems()
    }
    
    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage
    ) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
    
    private func setupTabBarItems() {
        viewControllers = [
            createNavController(for: ProfileViewController(viewModel: profileViewModel),
                                title: "Profile".localized(),
                                image: .Icons.profileTab!),
            
            createNavController(for: CatalogViewController(viewModel: catalogueViewModel),
                                title: "Catalog".localized(),
                                image: .Icons.catalogueTab!),
            
            createNavController(for: CartViewController(viewModel: cartViewModel),
                                title: "Cart".localized(),
                                image: .Icons.cartTab!),
            
            createNavController(for: StatisticViewController(viewModel: statisticViewModel),
                                title: "Statistics".localized(),
                                image: .Icons.statisticsTab!)
        ]
        tabBar.unselectedItemTintColor = .blackDay
    }
    
}
