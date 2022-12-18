//
//  AnnotationScreen.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 11.12.2022.
//

import UIKit

final class MapScreenAnnotationView: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
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
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initialize() {
        self.translatesAutoresizingMaskIntoConstraints = false

        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.contentInset).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.contentInset).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.contentInset).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true

        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    func configurate(entity: MetaObject<Entity>) {
//        subviews.forEach { subview in
//            subview.removeFromSuperview()
//        }
        titleLabel.text = entity.data?.text
        imageView.image = entity.image
    }

}
