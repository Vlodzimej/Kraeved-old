////
////  ActivityIndicatorView.swift
////  Kraeved
////
////  Created by Владимир Амелькин on 18.12.2022.
////
//
//import UIKit
//
//// MARK: - ActivityIndicatorView
//final class ActivityIndicatorView: UIViewController {
//
//    // MARK: UIConstants
//    struct UIConstants {
//        static let size: CGFloat = 96
//    }
//    
//    var spinner = UIActivityIndicatorView(style: .whiteLarge)
//
//    private let squareLayer: CALayer = {
//        let layer = CALayer()
//        layer.backgroundColor = UIColor.white.cgColor
//        layer.borderColor = UIColor.darkGray.cgColor
//        layer.borderWidth = 1
//        layer.cornerRadius = 8
//        return layer
//    }()
//    
//    override func loadView() {
//        view = UIView()
//        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
//
//        spinner.translatesAutoresizingMaskIntoConstraints = false
//        spinner.startAnimating()
//        view.addSubview(spinner)
//
//        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//    }
//
////    func configurate() {
////        squareLayer.frame = CGRect(x: view.frame.width / 2 - UIConstants.size / 2, y: view.frame.height / 2 - UIConstants.size / 2,
////                             width: UIConstants.size, height: UIConstants.size)
////
////        let rotationAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
////        rotationAnimation.toValue = NSNumber(value: Double.pi * 2)
////        rotationAnimation.duration = 1
////        rotationAnimation.isCumulative = true
////        rotationAnimation.repeatCount = Float.greatestFiniteMagnitude
////
////        view.layer.addSublayer(squareLayer)
////
////        CATransaction.begin()
////        squareLayer.add(rotationAnimation, forKey: "rotationAnimation")
////        CATransaction.commit()
////    }
//}
