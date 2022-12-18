//
//  OnboardingView.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 18.12.2022.
//

import UIKit

final class OnboardingView: UIView {

    private let eventsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.attributedText = NSAttributedString(string: NSLocalizedString("onboarding.events", comment: ""), attributes: [.font: UIFont.systemFont(ofSize: 28, weight: .semibold), .foregroundColor: UIColor.white])
        return label
    }()

    private let placesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.attributedText = NSAttributedString(string: NSLocalizedString("onboarding.places", comment: ""), attributes: [.font: UIFont.systemFont(ofSize: 28, weight: .semibold), .foregroundColor: UIColor.white])
        return label
    }()

    private let galleryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.attributedText = NSAttributedString(string: NSLocalizedString("onboarding.gallery", comment: ""), attributes: [.font: UIFont.systemFont(ofSize: 28, weight: .semibold), .foregroundColor: UIColor.white])
        return label
    }()

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initialize() {
        backgroundColor = UIColor(white: 0, alpha: 0.5)

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tap)

        addSubview(eventsLabel)
        eventsLabel.frame = CGRect(x: -100, y: 150, width: 400, height: 150)

        addSubview(placesLabel)
        placesLabel.frame = CGRect(x: 300, y: 350, width: 400, height: 150)

        addSubview(galleryLabel)
        galleryLabel.frame = CGRect(x: -100, y: 550, width: 400, height: 150)

        UIView.animate(withDuration: 1.5, delay: 0, options: [.curveEaseOut], animations: {
            self.eventsLabel.center.x += 130
            self.eventsLabel.layoutIfNeeded()

            self.placesLabel.center.x -= 230
            self.placesLabel.layoutIfNeeded()

            self.galleryLabel.center.x += 130
            self.galleryLabel.layoutIfNeeded()
        }, completion: nil)
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        removeFromSuperview()
    }
}
