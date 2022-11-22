//
//  MainTableCellFactory.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 23.11.2022.
//

import UIKit

//MARK: - MainTableCellViewFactory
class MainTableCellViewFactory {
    
    func makeHistoricalEventCellView(items: [MainTableCellItem], delegate: HistoricalEventCellDelegate?) -> UIView {
        let cellView = HistoricalEventCellView(items: items)
        cellView.delegate = delegate
        return cellView
    }
    
    func makeGalleryCellView(items: [MainTableCellItem]) -> UIView {
        let cellView = HistoricalEventCellView(items: items)
        return cellView
    }
}
