//
//  EntitytCollectionCell.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 20.11.2022.
//

import UIKit
import SnapKit

// MARK: - EntitytCollectionCell
final class EntityCollectionCell: CollectionCellWithShimmer {
    
    // MARK: UIConstants
    struct UIConstants {
        static let titleHorizintalInsets: CGFloat = 8
        static let titleBottomInset: CGFloat = 8
        static let titleLabelFontSize: CGFloat = 11
    }
    
    // MARK: UIProperties
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = false
        view.layer.cornerRadius = Constants.mainTableElementRadius
        view.layer.borderColor = UIColor.HEX.hDDE3E3.cgColor
        view.layer.borderWidth = 2
        
        view.layer.shadowColor = UIColor.HEX.h00000040.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let titleContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .HEX.hECEADD
        view.clipsToBounds = true
        view.layer.cornerRadius = Constants.mainTableElementRadius
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.layer.opacity = 0.95
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Constants.mainTableElementRadius
        return imageView
    }()
    
    private lazy var gradientMaskLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.frame = contentView.bounds
        layer.colors = [UIColor.white.cgColor, UIColor.clear.cgColor]
        layer.locations = [0, 0.85]
        return layer
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods
    private func initialize() {
        containerView.backgroundColor = generateRandomPastelColor(withMixedColor: UIColor.black)
        
        containerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.snp.makeConstraints { maker in
            maker.top.bottom.leading.trailing.equalToSuperview()
        }
        
        containerView.addSubview(titleContainerView)
        titleContainerView.snp.makeConstraints { maker in
            maker.top.equalTo(containerView.snp.bottom).inset(42)
            maker.leading.trailing.bottom.equalToSuperview()
        }
        
        titleContainerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview().inset(UIConstants.titleBottomInset)
            maker.top.equalToSuperview()
            maker.trailing.leading.equalToSuperview().inset(UIConstants.titleHorizintalInsets)
        }
        
        addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    }
    
    // MARK: Public Methods
    func configurate(title: String?, image: UIImage?, hasOverlay: Bool = false) {
        
        if let image = image {
            imageView.image = image
            imageView.isHidden = false
            //imageView.layer.mask = hasOverlay ? gradientMaskLayer : nil
            
            //let averageColor = image.averageColor()
            //containerView.backgroundColor = averageColor.mix(with: UIColor.black, amount: 0.65)
        } else {
            imageView.isHidden = true
        }
        
        if let title = title {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.0
            let  titleAttributedString = NSMutableAttributedString(string: title, attributes:
                                                                    [.font: UIFont.BeVietnamPro.Normal(withSize: UIConstants.titleLabelFontSize), .foregroundColor: UIColor.HEX.h242424D9, .paragraphStyle: paragraphStyle])
            titleLabel.attributedText = titleAttributedString
            titleLabel.isHidden = false
            
            for family in UIFont.familyNames.sorted() {
                let names = UIFont.fontNames(forFamilyName: family)
                print("Family: \(family) Font names: \(names)")
            }
        } else {
            titleLabel.isHidden = true
        }
    }
}
