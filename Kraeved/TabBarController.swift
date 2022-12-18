//
//  TabBarController.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 01.11.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    private let activityIndicatorView = ActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
        UITabBar.appearance().barTintColor = .white
        tabBar.tintColor = .black

        initialize()
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeActivityIndicatorVisibility(_:)), name: .changeActivityIndicatorVisibility, object: nil)
    }

    private func initialize() {
        let mainScreenViewController = MainScreenModuleBuilder.build()
        let mapScreenViewController = MapScreenModuleBuilder.build()
        let searchScreenViewController = SearchScreenModuleBuilder.build()
        let profileViewController = ProfileModuleBuilder.build()

        viewControllers = [
            createNavController(for: mainScreenViewController, title: NSLocalizedString("tabbar.mainScreen", comment: ""), image: UIImage(named: "house")!),
            createNavController(for: searchScreenViewController, title: NSLocalizedString("tabbar.searchScreen", comment: ""), image: UIImage(named: "magnifyingglass")!),
            createNavController(for: mapScreenViewController, title: NSLocalizedString("tabbar.mapScreen", comment: ""), image: UIImage(named: "figure.walk")!),
            createNavController(for: profileViewController, title: NSLocalizedString("tabbar.profile", comment: ""), image: UIImage(named: "person.crop.circle")!)
        ]
    }

    private func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        return navController
    }
    
    @objc func changeActivityIndicatorVisibility(_ notification: NSNotification) {
        let isVisible = notification.userInfo?["isVisible"] as? Bool ?? false

        if isVisible {
            view.addSubview(activityIndicatorView)

            activityIndicatorView.frame = CGRect(x: view.frame.width / 2 - ActivityIndicatorView.UIConstants.size / 2,
                                                 y: view.frame.height / 2 - ActivityIndicatorView.UIConstants.size / 2,
                                                 width: ActivityIndicatorView.UIConstants.size, height: ActivityIndicatorView.UIConstants.size)

            activityIndicatorView.configurate()
        } else {
            activityIndicatorView.removeFromSuperview()
        }
    }
}
