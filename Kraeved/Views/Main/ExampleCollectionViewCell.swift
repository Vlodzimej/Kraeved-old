//
//  ExampleCollectionViewCell.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 20.06.2023.
//

import Foundation
import SnapKit

class ExampleCollectionViewCell: UICollectionViewCell {
    private let exampleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .yellow
        return imageView
    }()
    
    private let exampleLabel: UILabel = {
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
        addSubview(exampleImageView)
        addSubview(exampleLabel)
    }
    
    func configureCell(exampleName: String, imageName: String) {
        exampleLabel.text = exampleName
        //exampleImageView.image = UIImage(named: imageName)
    }
    
    func setConstraints() {
        
        exampleLabel.snp.makeConstraints { maker in
            maker.leading.trailing.bottom.equalToSuperview().inset(5)
            maker.height.equalTo(16)
        }
        
        exampleImageView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().inset(5)
        }
        
    }
}
