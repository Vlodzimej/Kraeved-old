//
//  AnnotationAddingView.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 25.12.2022.
//

import UIKit
import KraevedKit
import MapKit

// MARK: - AnnotationAddingMode
enum AnnotationAddingMode {
    case location
    case name
    case description
}

// MARK: - AnnotationAddingViewDelegate
protocol AnnotationAddingViewDelegate: AnyObject {
    func addAnnotation(title: String, description: String)
}

// MARK: - AnnotationAddingViewProtocol
protocol AnnotationAddingViewProtocol: AnyObject {
    func update(mode: AnnotationAddingMode)
}

// MARK: - AnnotationAddingView
class AnnotationAddingView: UIView, AnnotationAddingViewProtocol {

    // MARK: UIConstants
    struct UIConstants {
        static let fontSize: CGFloat = 16
    }
    
    // MARK: Properties
    private var mode: AnnotationAddingMode?
    weak var delegate: AnnotationAddingViewDelegate?

    // MARK: UI Properties
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("mapScreen.selectCoords", comment: "")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: UIConstants.fontSize, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var coordsTextField: KTextField = {
        let textField = KTextField()
        textField.placeholder = NSLocalizedString("mapScreen.coordinates", comment: "")
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .gray
        textField.textAlignment = .center
        return textField
    }()

    private lazy var nameTextField: KTextField = {
        let textField = KTextField()
        textField.placeholder = NSLocalizedString("mapScreen.newLocation", comment: "")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: UIConstants.fontSize, weight: .regular)
        textField.textColor = .gray
        textField.delegate = self
        textField.addTarget(self, action: #selector(nameTextFieldDidChange), for: .editingChanged)
        return textField
    }()

    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: UIConstants.fontSize, weight: .regular)
        textView.textColor = .gray
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 0)
        textView.isHidden = true
        return textView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("mapScreen.enterNewLocationName", comment: "")
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("mapScreen.enterNewLocationDescription", comment: "")
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("common.next", comment: ""), for: .normal)
        button.setTitleColor(UIColor.Common.greenMain, for: .normal)
        button.setTitleColor(UIColor.gray, for: .disabled)
        button.tintColor = UIColor.Common.greenMain
        button.setImage(UIImage.Common.next, for: .normal)
        button.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.isEnabled = false
        button.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        return button
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
        // TODO: Необходимо провести рефакторинг

        addSubview(nextButton)
        nextButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.contentInset).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        addSubview(locationLabel)
        locationLabel.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: Constants.contentInset).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        addSubview(coordsTextField)
        coordsTextField.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: Constants.contentInset).isActive = true
        coordsTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.contentInset).isActive = true
        coordsTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.contentInset).isActive = true

        addSubview(nameTextField)
        nameTextField.topAnchor.constraint(equalTo: nextButton.bottomAnchor).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.contentInset).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.contentInset).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 8).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        addSubview(descriptionTextView)
        descriptionTextView.topAnchor.constraint(equalTo: nextButton.bottomAnchor).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.contentInset).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.contentInset).isActive = true
        descriptionTextView.heightAnchor.constraint(equalToConstant: 128).isActive = true
        
        addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        update(mode: .location)
    }
    
    @objc private func nextButtonTapped(_ sender: UIButton) {
        guard let mode else { return }
        switch mode {
            case .location:
                update(mode: .name)
            case .name:
                update(mode: .description)
            case .description:
                done()
        }
    }
    
    @objc private func nameTextFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        nextButton.isEnabled = text.count > 2
    }
    
    // MARK: Public Methods
    func update(mode: AnnotationAddingMode) {
        // TODO: Необходимо провести рефакторинг
        self.mode = mode
        
        switch mode {
            case .location:
                locationLabel.isHidden = false
                nameTextField.isHidden = true
                nameLabel.isHidden = true
                nextButton.isEnabled = false
                descriptionTextView.isHidden = true
                descriptionLabel.isHidden = true
                coordsTextField.isHidden = false
                coordsTextField.text = ""
            case .name:
                locationLabel.isHidden = true
                nameTextField.isHidden = false
                nameLabel.isHidden = false
                nextButton.isEnabled = false
                coordsTextField.isHidden = true
            case .description:
                nameTextField.isHidden = true
                nameLabel.isHidden = true
                descriptionTextView.isHidden = false
                descriptionLabel.isHidden = false
                nextButton.isEnabled = true
        }
    }
    
    func reset() {
        update(mode: .location)
    }
    
    func done() {
        delegate?.addAnnotation(title: nameTextField.text ?? "", description: descriptionTextView.text)
    }
}

// MARK: - UITextFieldDelegate
extension AnnotationAddingView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
}

// MARK: - MapScreenModuleOutput
extension AnnotationAddingView: MapScreenModuleOutput {
    func locationDidSelect(annotation: MKAnnotation) {
        nextButton.isEnabled = true
        coordsTextField.text = "\(annotation.coordinate.latitude), \(annotation.coordinate.longitude)"
    }
}
