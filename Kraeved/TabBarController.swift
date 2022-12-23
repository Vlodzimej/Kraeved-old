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
        NotificationCenter.default.addObserver(self, selector: #selector(showOnboarding), name: .showOnboarding, object: nil)
    }

    private func initialize() {
        let mainScreenViewController = MainScreenModuleBuilder.build()
        let searchScreenViewController = SearchScreenModuleBuilder.build()
        let mapScreenViewController = MapScreenModuleBuilder.build()
        let miniAppsScreenViewController = MiniAppsScreenModuleBuilder.build()
        let profileViewController = ProfileModuleBuilder.build()

        viewControllers = [
            createNavController(for: mainScreenViewController, title: NSLocalizedString("tabbar.mainScreen", comment: ""), image: UIImage.TabBar.main),
            createNavController(for: searchScreenViewController, title: NSLocalizedString("tabbar.searchScreen", comment: ""), image: UIImage.TabBar.search),
            createNavController(for: mapScreenViewController, title: NSLocalizedString("tabbar.mapScreen", comment: ""), image: UIImage.TabBar.map),
            createNavController(for: miniAppsScreenViewController, title: NSLocalizedString("tabbar.miniapps", comment: ""), image: UIImage.TabBar.miniapps),
            createNavController(for: profileViewController, title: NSLocalizedString("tabbar.profile", comment: ""), image: UIImage.TabBar.profile)
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
        } else {
            activityIndicatorView.removeFromSuperview()
        }
    }

    @objc func showOnboarding() {
        let onboardingView = OnboardingView()
        view.addSubview(onboardingView)

        onboardingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        onboardingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        onboardingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        onboardingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
