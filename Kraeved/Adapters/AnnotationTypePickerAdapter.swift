//
//  AnnotationTypePickerAdapter.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 06.01.2023.
//

import UIKit

enum AnnotationType: String, CaseIterable {
    case location = "Локация"
    case nature = "Природный объект"
    case building = "Строение"
    case note = "Заметка"
}

protocol AnnotationTypePickerAdapterProtocol: UIPickerViewDelegate, UIPickerViewDataSource {
    
}

// MARK: - AnnotationTypePickerAdapter
final class AnnotationTypePickerAdapter: NSObject, AnnotationTypePickerAdapterProtocol {
    
    private var pickerView: UIPickerView?
    
    private let items = AnnotationType.allCases
    
    func configurate(pickerView: UIPickerView) {
        pickerView.delegate = self
        pickerView.dataSource = self
        self.pickerView = pickerView
    }
}

extension AnnotationTypePickerAdapter: UIPickerViewDelegate {
    
}

extension AnnotationTypePickerAdapter: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        items[row].rawValue
    }
}
