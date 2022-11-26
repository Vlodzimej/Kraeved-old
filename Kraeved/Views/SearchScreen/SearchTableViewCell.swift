//
//  SearchTableViewCell.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 26.11.2022.
//

import UIKit

//MARK: - SearchTableViewCell
class SearchTableViewCell: UITableViewCell {
    
    //MARK: UIConstants
    struct UIConstatns {
        static let cellHeight: CGFloat = 64
        static let iconViewMargin: CGFloat = 8
        static let iconViewSize: CGFloat = 32
    }
    
    //MARK: UIProperties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: Public Methods
    func configurate(title: String) {
        selectionStyle = .none
        
        for view in contentView.subviews {
            view.removeFromSuperview()
        }
        
        iconView.image = UIImage(named: "globe.europe.africa.fill")!
        iconView.tintColor = .gray
        contentView.addSubview(iconView)
        iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstatns.iconViewMargin).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: UIConstatns.iconViewSize).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: UIConstatns.iconViewSize).isActive = true

        titleLabel.text = title
        contentView.addSubview(titleLabel)
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: UIConstatns.iconViewMargin).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
}
