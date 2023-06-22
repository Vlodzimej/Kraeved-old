//
//  ActivityIndicatorView.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 18.12.2022.
//

import UIKit
import SnapKit


// MARK: - ActivityIndicatorView
final class ActivityIndicatorView: UIViewController {

    var spinner = UIActivityIndicatorView(style: .large)
        
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.1)

        spinner.color = UIColor.gray
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }
    }
}
