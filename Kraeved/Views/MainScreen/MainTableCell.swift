//
//  MainTableCell.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 20.11.2022.
//

import UIKit

class MainTableCell: UITableViewCell {
    
    struct UIConstants {
        static let headerTitleHeight: CGFloat = 32
        static let cellHeight: CGFloat = 200
    }
    
    private var hasHeader = false
    
    private let titleLabel = UILabel()
    
    func configurate(section: MainTableSectionItem, titleText: String?) {
        backgroundColor = .clear
        
        let cellViewFactory = MainTableCellViewFactory()
        let cellView: UIView
        
        switch section.type {
            case .historicalEvents:
                cellView = cellViewFactory.makeHistoricalEventCellView(items: section.items)
                
            case .gallery:
                cellView = cellViewFactory.makeHistoricalEventCellView(items: section.items)
        }
        
        if let titleText = titleText {
            titleLabel.attributedText = NSAttributedString(string: titleText, attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .semibold), .foregroundColor: UIColor.black])
            titleLabel.frame = CGRect(x: Constants.contentInset, y: 0, width: self.bounds.width, height: UIConstants.headerTitleHeight)
            contentView.addSubview(titleLabel)
            hasHeader = true
        }
        
        contentView.addSubview(cellView)
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: hasHeader ? UIConstants.headerTitleHeight : 0).isActive = true
        cellView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        cellView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}

class MainTableCellViewFactory {
    func makeHistoricalEventCellView(items: [MainTableCellItem]) -> UIView {
        return HistoricalEventCellView(items: items)
    }
    
    func makeGalleryCellView(items: [MainTableCellItem]) -> UIView {
        return HistoricalEventCellView(items: items)
    }
}

