//
//  MapScreenAnnotationInfoView.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 11.12.2022.
//

import UIKit

// MARK: - MapScreenAnnotationInfoView
final class MapScreenAnnotationInfoView: UIView {
    
    struct UIConstants {
        static let titleHorizontalInset: CGFloat = 24
    }
    
    private let discriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    init() {
        super.init(frame: .zero)
        initialize()
        backgroundColor = .Common.greenBackground
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initialize() {
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        addSubview(discriptionLabel)
        discriptionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.contentInset).isActive = true
        discriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIConstants.titleHorizontalInset).isActive = true
        discriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UIConstants.titleHorizontalInset).isActive = true
        discriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.contentInset).isActive = true
    }

    func configurate(entity: MetaObject<Entity>) {
        discriptionLabel.text = entity.data?.text
        imageView.image = entity.image
    }

}
