//
//  AnnotationCollectionViewCell.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 21.06.2023.
//

import Foundation
import SnapKit

// MARK: - AnnotationCollectionViewCell
final class AnnotationCollectionViewCell: UICollectionViewCell {
    
    // MARK: UIConstants
    struct UIConstants {
        static let titleLabelFontSize: CGFloat = 13
    }
    
    // MARK: UIProperites
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Constants.mainTableElementRadius
        return imageView
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    private func initialize() {
        addSubview(imageView)
        addSubview(titleLabel)
        
        imageView.snp.makeConstraints { maker in
            maker.leading.top.bottom.equalToSuperview().inset(8)
            maker.width.equalTo(72)
        }

        titleLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(imageView.snp.trailing).offset(8)
            maker.top.equalToSuperview().inset(18)
            maker.trailing.equalToSuperview().inset(24)
        }
    }
    
    // MARK: Public methods
    func configure(title: String?, image: UIImage?) {
        if let title {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.0
            titleLabel.attributedText = NSMutableAttributedString(string: title,
                                                                  attributes: [
                                                                    .font: UIFont.BeVietnamPro.Regular(withSize: UIConstants.titleLabelFontSize),
                                                                    .foregroundColor: UIColor.HEX.h242424D9,
                                                                    .paragraphStyle: paragraphStyle
                                                                  ])
        }
        if let image {
            imageView.image = image
        }
    }
}
