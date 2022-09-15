//
//  ViewController.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 15.09.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private lazy var tabBarVC: UITabBarController = {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .white
        
        let mainVC = MapViewController()
        mainVC.tabBarItem = UITabBarItem.init(title: "Карта", image: UIImage(systemName: "figure.walk"), tag: 0)
        
        let profileVC = HomeViewController()
        profileVC.tabBarItem = UITabBarItem.init(title: "Профиль", image: UIImage(systemName: "house"), tag: 1)
        
        let controllerArray = [mainVC, profileVC]
        tabBarController.viewControllers = controllerArray.map { UINavigationController.init(rootViewController: $0) }
        
        return tabBarController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .black
        view.addSubview(tabBarVC.view)
    }
}
