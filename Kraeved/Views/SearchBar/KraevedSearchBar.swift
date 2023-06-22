//
//  SearchBar.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 22.06.2023.
//

import UIKit

class KraevedSearchBar: UISearchBar {
    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        
        if let textfield = value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor.MainScreen.searchBarTextField
            textfield.clipsToBounds = true
            textfield.layer.borderColor = UIColor.MainScreen.cellBorder.cgColor
            textfield.layer.borderWidth = 1
            textfield.layer.cornerRadius = 12
            textfield.textColor = .Common.foreground
            textfield.leftView?.tintColor = .Common.foreground
        }

        let clearImage = UIImage.Common.clear.withTintColor(.Common.foreground, renderingMode: .alwaysOriginal)
        setImage(clearImage, for: .clear, state: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
