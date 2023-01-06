//
//  MapScreenAnnotationInfoView.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 11.12.2022.
//

import UIKit

// MARK: - MapScreenAnnotationInfoView
final class MapScreenAnnotationInfoView: UIView {
    
    // MARK: UIConstants
    struct UIConstants {
        static let titleHorizontalInset: CGFloat = 24
    }
    
    // MARK: UIProperties
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.contentMode = .topLeft
        label.numberOfLines = 0
        return label
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    // MARK: Init
    init() {
        super.init(frame: .zero)
        initialize()
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods
    private func initialize() {
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.contentInset).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIConstants.titleHorizontalInset).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UIConstants.titleHorizontalInset).isActive = true
    }

    // MARK: Public Methods
    func configurate(entity: MetaObject<Entity>) {
        descriptionLabel.text = entity.data?.text
        imageView.image = entity.image
    }

}
