//
//  MainTableCell.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 20.11.2022.
//

import UIKit

class MainTableCell: UITableViewCell {
    
    struct UIConstants {
        static let headerTitleHeight: CGFloat = 24
        static let cellHeight: CGFloat = 160
    }
    
    private var hasHeader = false
    
    func configurate(section: MainTableSectionItem, titleText: String?) {
        backgroundColor = .clear
        
        let cellViewFactory = MainTableCellViewFactory()
        let cellView: UIView
        
        switch section.type {
            case .historicalEvents:
                cellView = cellViewFactory.makeHistoryEventCellView(items: section.items)
                
            case .gallery:
                cellView = cellViewFactory.makeHistoryEventCellView(items: section.items)
        }
        
        if let titleText = titleText {
            let titleLabel = UILabel()
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
    func makeHistoryEventCellView(items: [MainTableCellItem]) -> UIView {
        return HistoryEventCellView(items: items)
    }
    
    func makeGalleryCellView(items: [MainTableCellItem]) -> UIView {
        return HistoryEventCellView(items: items)
    }
}

