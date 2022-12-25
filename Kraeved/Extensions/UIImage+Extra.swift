//
//  UIImage+extra.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 11.12.2022.
//

import UIKit

extension UIImage {
    struct Common {
        static var plus: UIImage { UIImage(named: "plus" )! }
        static var xmark: UIImage { UIImage(named: "xmark" )! }
        static var location: UIImage { UIImage(named: "globe.europe.africa.fill")! }
    }

    struct TabBar {
        static var main: UIImage { UIImage(named: "house")! }
        static var search: UIImage { UIImage(named: "magnifyingglass")! }
        static var map: UIImage { UIImage(named: "figure.walk")! }
        static var miniapps: UIImage { UIImage(named: "miniapps")! }
        static var profile: UIImage { UIImage(named: "person.crop.circle")! }
        static var mapInactive: UIImage { UIImage(named: "map_button_inactive")! }
        static var mapActive: UIImage { UIImage(named: "map_button_active")! }
    }
}
