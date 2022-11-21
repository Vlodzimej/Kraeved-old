//
//  HistoryEventCollectionCell.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 20.11.2022.
//

import UIKit

class HistoryEventCollectionCell: UICollectionViewCell {
    
    private let titleLabel = UILabel()

    func configurate(title: String, image: UIImage?) {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = generateRandomPastelColor(withMixedColor: nil)
        contentView.addSubview(titleLabel)
        titleLabel.frame = CGRect(x: 0, y: 0, width: 96, height: 96)
        titleLabel.text = title
    }
}
