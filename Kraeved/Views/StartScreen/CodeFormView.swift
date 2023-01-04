//
//  CodeFormView.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 04.01.2023.
//

import UIKit
import KraevedKit

protocol CodeFormViewDelegate {
    func sendCode(_ code: String)
}

class CodeFormView: UIView {
    
    private let codeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Введите код из СМС"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var codeField: KTextField = {
        let textField = KTextField()
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.textAlignment = .center
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(codeLabel)
        codeLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        codeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        codeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        addSubview(codeField)
        codeField.topAnchor.constraint(equalTo: codeLabel.bottomAnchor, constant: Constants.contentInset).isActive = true
        codeField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        codeField.widthAnchor.constraint(equalToConstant: 64).isActive = true
    }
}

extension CodeFormView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        if text.count == 4 {
            return false
        }
        return true
    }
}
