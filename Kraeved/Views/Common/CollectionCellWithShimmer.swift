//
//  CollectionCellWithShimmer.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 25.11.2022.
//

import UIKit

class CollectionCellWithShimmer: UICollectionViewCell {
    
    var gradientColorOne: CGColor = UIColor(white: 0.85, alpha: 1.0).cgColor
    var gradientColorTwo: CGColor = UIColor(white: 0.95, alpha: 1.0).cgColor
    
    func startAnimating() {
        let gradientLayer = CAGradientLayer()
        /* Allocate the frame of the gradient layer as the view's bounds, since the layer will sit on top of the view. */
        
        gradientLayer.frame = self.bounds
        /* To make the gradient appear moving from left to right, we are providing it the appropriate start and end points.
         Refer to the diagram above to understand why we chose the following points.
         */
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [gradientColorOne, gradientColorTwo,   gradientColorOne]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        /* Adding the gradient layer on to the view */
        layer.addSublayer(gradientLayer)
        layer.masksToBounds = true
        layer.cornerRadius = Constants.mainTableElementRadius
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.speed = 0.3
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: animation.keyPath)
    }
}
