//
//  SaleCollectionViewCell.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 20.06.2023.
//

import Foundation
import SnapKit

class SaleCollectionViewCell: UICollectionViewCell {
    private let saleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
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
        addSubview(saleImageView)
    }
    
    func configureCell(imageName: String) {
        //saleImageView.image = UIImage(named: imageName)
    }
    
    func setConstraints() {
        saleImageView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
}
