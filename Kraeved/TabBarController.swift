//
//  TabBarController.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 01.11.2022.
//

import UIKit
import SnapKit

// MARK: - TabBarController
final class TabBarController: UITabBarController, UITabBarControllerDelegate {

    // MARK: UIConstants
    struct UIConstants {
        static let mapButtonViewTopInset: CGFloat = 16
        static let mapButtonViewInsets: CGFloat = 8
    }
    
    // MARK: Properties
    private let activityIndicatorView = ActivityIndicatorView()
    
    private var onboardingTimer: Timer?

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        tabBar.backgroundColor = .white
        UITabBar.appearance().barTintColor = .white
        tabBar.tintColor = .Common.greenMain
        tabBar.unselectedItemTintColor = .TabBar.tabBarItem

        initialize()

        NotificationCenter.default.addObserver(self, selector: #selector(changeActivityIndicatorVisibility(_:)), name: .changeActivityIndicatorVisibility, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showOnboarding), name: .showOnboarding, object: nil)
    }

    // MARK: Private Methods
    private func initialize() {
        let mainScreenViewController = MainScreenModuleBuilder.build()
        let favoriteScreenViewController = FavoriteScreenModuleBuilder.build()
        let mapScreenViewController = MapScreenModuleBuilder.build()
        let miniAppsScreenViewController = MiniAppsScreenModuleBuilder.build()
        let profileViewController = ProfileModuleBuilder.build()

        viewControllers = [
            createNavController(for: mainScreenViewController, title: NSLocalizedString("tabbar.mainScreen", comment: ""), image: UIImage.TabBar.main),
            createNavController(for: favoriteScreenViewController, title: NSLocalizedString("tabbar.favorites", comment: ""), image: UIImage.TabBar.favorites),
            createNavController(for: mapScreenViewController),
            createNavController(for: miniAppsScreenViewController, title: NSLocalizedString("tabbar.miniApps", comment: ""), image: UIImage.TabBar.miniapps),
            createNavController(for: profileViewController, title: NSLocalizedString("tabbar.profile", comment: ""), image: UIImage.TabBar.profile)
        ]

        setMapTabBarItemView()
    }

    private func createNavController(for rootViewController: UIViewController, title: String? = nil, image: UIImage = UIImage()) -> UIViewController {
        let navController = NavController(rootViewController: rootViewController)
        rootViewController.navigationItem.title = title
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.backgroundColor = .none
        
        navController.navigationBar.standardAppearance = navBarAppearance
        navController.navigationBar.compactAppearance = navBarAppearance
        navController.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navController.navigationBar.isTranslucent = true
        navController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }

    private func setMapTabBarItemView(itemIndex: Int = 2, isActive: Bool = false) {
        guard let mapTabItemView = tabBar.subviews[safeIndex: itemIndex] else { return }

        let image = isActive ? UIImage.TabBar.mapActive : UIImage.TabBar.mapInactive
        let buttonView = UIImageView(image: image.withAlignmentRectInsets(UIEdgeInsets(top: UIConstants.mapButtonViewTopInset, left: UIConstants.mapButtonViewInsets, bottom: UIConstants.mapButtonViewInsets, right: UIConstants.mapButtonViewInsets)))
        buttonView.backgroundColor = .clear
        buttonView.contentMode = .scaleAspectFit

        mapTabItemView.subviews.forEach { $0.removeFromSuperview() }
        mapTabItemView.addSubview(buttonView)
        buttonView.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview()
            maker.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    @objc private func changeActivityIndicatorVisibility(_ notification: NSNotification) {
        let isVisible = notification.userInfo?["isVisible"] as? Bool ?? false

        if isVisible {
            addChild(activityIndicatorView)
            activityIndicatorView.view.frame = view.frame
            view.addSubview(activityIndicatorView.view)
            activityIndicatorView.didMove(toParent: self)
        } else {
            activityIndicatorView.willMove(toParent: nil)
            activityIndicatorView.view.removeFromSuperview()
            activityIndicatorView.removeFromParent()
        }
    }

    @objc private func showOnboarding() {
        if UserDefaults.standard.bool(forKey: UserDefaultConstants.isOnboardingShown.rawValue) {
            return
        }

        UserDefaults.standard.set(true, forKey: UserDefaultConstants.isOnboardingShown.rawValue)
        
        onboardingTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { [weak self] _ in
            guard let self else { return }
            let onboardingView = OnboardingView()
            self.view.addSubview(onboardingView)
            
            onboardingView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            onboardingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            onboardingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            onboardingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        }
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        onboardingTimer?.invalidate()
        guard let itemIndex = tabBar.items?.firstIndex(of: item) else { return }
        setMapTabBarItemView(itemIndex: 3, isActive: itemIndex == 2)
    }
}
