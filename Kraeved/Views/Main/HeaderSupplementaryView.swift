//
//  HeaderSupplementaryView.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 20.06.2023.
//

import Foundation
import SnapKit

class HeaderSupplementaryView: UICollectionReusableView {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.HEX.h1A8F8F
        return label
    }()
    
    private let separatorView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.MainScreen.entityCollectionSeparator
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .none
        
        addSubview(headerLabel)
        addSubview(separatorView)
        
        headerLabel.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.leading.equalToSuperview().offset(10)
        }
        
        separatorView.snp.makeConstraints { maker in
            maker.top.equalTo(headerLabel.snp.bottom).inset(8)
            maker.leading.equalToSuperview()
            maker.width.equalTo(128)
            maker.height.equalTo(24)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHeader(categoryName: String) {
        headerLabel.text = categoryName
    }
}
