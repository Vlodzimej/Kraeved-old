//
//  CategoryCollectionViewCell.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 20.06.2023.
//

import Foundation
import SnapKit

class CategoryCollectionViewCell: UICollectionViewCell {
    private let categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .green
        return imageView
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .white
        addSubview(categoryImageView)
        addSubview(categoryLabel)
    }
    
    func configureCell(categoryName: String, imageName: String) {
        categoryLabel.text = categoryName
        categoryImageView.image = UIImage(named: imageName)
    }
    
    func setConstraints() {
        
        categoryLabel.snp.makeConstraints { maker in
            maker.leading.trailing.bottom.equalToSuperview().inset(5)
            maker.height.equalTo(16)
        }
        
        categoryImageView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().inset(5)
        }
        
    }
}
