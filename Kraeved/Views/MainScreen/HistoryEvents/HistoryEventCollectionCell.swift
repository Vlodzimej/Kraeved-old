//
//  HistoricalEventCollectionCell.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 20.11.2022.
//

import UIKit

class HistoricalEventCollectionCell: UICollectionViewCell {
    
    struct UIConstants {
        static let titleInset: CGFloat = 8
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let overlay: CAGradientLayer = {
        let overlay = CAGradientLayer()
        
        return overlay
    }()

    func configurate(title: String?, image: UIImage?) {

        layer.masksToBounds = true
        layer.cornerRadius = 12
        if let image = image {
            imageView.contentMode = .scaleAspectFill
            imageView.image = image

            let averageColor = image.averageColor()
            backgroundColor = averageColor.mix(with: UIColor.black, amount: 0.65)
            
            contentView.addSubview(imageView)

            imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true

            let gradientMaskLayer = CAGradientLayer()
            gradientMaskLayer.frame = contentView.bounds
            gradientMaskLayer.colors = [UIColor.white.cgColor, UIColor.clear.cgColor]
            gradientMaskLayer.locations = [0, 0.85]
            contentView.layer.mask = gradientMaskLayer
        } else {
            backgroundColor = generateRandomPastelColor(withMixedColor: UIColor.black)
        }
        
        if let title = title {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 0.8
            let titleAttributedString = NSMutableAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .regular), .foregroundColor: UIColor.white, .paragraphStyle: paragraphStyle])
            
            titleLabel.attributedText = titleAttributedString
            titleLabel.layer.masksToBounds = false
            
            addSubview(titleLabel)
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor).isActive = true
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.titleInset).isActive = true
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIConstants.titleInset).isActive = true
        }
    }
}
