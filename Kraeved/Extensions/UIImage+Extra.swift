//
//  UIImage+extra.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 11.12.2022.
//

import UIKit

extension UIImage {
    
    struct Start {
        static var horizon: UIImage { UIImage(named: "horizon")! }
    }
    
    struct Common {
        static var plus: UIImage { UIImage(named: "plus" )! }
        static var xmark: UIImage { UIImage(named: "xmark" )! }
        static var location: UIImage { UIImage(named: "globe.europe.africa.fill")! }
        static var next: UIImage { UIImage(named: "arrow.right.circle")! }
        static var logoSmall: UIImage { UIImage(named: "logo_small")! }
        static var locationPlaceholder: UIImage { UIImage(named: "location_placeholder")! }
        static var clear: UIImage { UIImage(systemName: "xmark.circle.fill")! }
        static var search: UIImage { UIImage(systemName: "magnifyingglass")! }
    }

    struct TabBar {
        static var main: UIImage { UIImage(systemName: "house")! }
        static var search: UIImage { UIImage(systemName: "magnifyingglass")! }
        static var map: UIImage { UIImage(systemName: "figure.walk")! }
        static var miniapps: UIImage { UIImage(systemName: "squareshape.split.2x2")! }
        static var profile: UIImage { UIImage(systemName: "person.crop.circle")! }
        static var mapInactive: UIImage { UIImage(named: "map_button_inactive")! }
        static var mapActive: UIImage { UIImage(named: "map_button_active")! }
        static var favorites: UIImage { UIImage(systemName: "heart")! }
    }
    
    struct MiniApps {
        static var notes: UIImage { UIImage(named: "notes")! }
        static var genealogy: UIImage { UIImage(named: "tree")! }
        static var shelter: UIImage { UIImage(named: "dog")! }
        static var education: UIImage { UIImage(named: "education")! }
    }
    
    struct MainScreen {
        static var entityCollectionSeparator: UIImage { UIImage(named: "entityCollectionSeparator")! }
    }
}
