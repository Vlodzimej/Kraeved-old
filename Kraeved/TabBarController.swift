//
//  TabBarController.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 01.11.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label

        initialize()
    }
    
    private func initialize() {
        let mapScreenViewController = MapScreenModuleBuilder.build()
        let searchScrennViewController = SearchScreenModuleBuilder.build()
        
        viewControllers = [
            createNavController(for: mapScreenViewController, title: NSLocalizedString("tabbar.mainScreen", comment: ""), image: UIImage(systemName: "house")!),
            createNavController(for: mapScreenViewController, title: NSLocalizedString("tabbar.mapScreen", comment: ""), image: UIImage(systemName: "figure.walk")!),
            createNavController(for: searchScrennViewController, title: NSLocalizedString("tabbar.searchScreen", comment: ""), image: UIImage(systemName: "magnifyingglass")!),
        ]
    }
    
    private func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
}
