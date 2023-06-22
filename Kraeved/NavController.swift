//
//  NavController.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 22.06.2023.
//

import UIKit

//MARK: - NavController
final class NavController: UINavigationController {
    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
}
