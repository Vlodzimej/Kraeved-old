//
//  MockData.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 20.06.2023.
//

import UIKit

struct MockData {
    static let shared = MockData()
    
    private let stories: MainScreenSection = {
        .stories([.init(title: "Тестовая надпись 1", image: UIImage(imageLiteralResourceName: "fastfood1")), .init(title: "Тестовая надпись 2", image: UIImage(imageLiteralResourceName: "fastfood3")), .init(title: "Тестовая надпись длинная для проверки", image: UIImage(imageLiteralResourceName: "fastfood4")), .init(title: "Тестовая надпись 4", image: UIImage(imageLiteralResourceName: "fastfood1")), .init(title: "Тестовая надпись 5", image: UIImage(imageLiteralResourceName: "fastfood1"))])
    }()

    var pageData: [MainScreenSection] {
        [stories]
    }
}
