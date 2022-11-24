//
//  MainTableCell.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 20.11.2022.
//

import UIKit

//MARK: - MainTableCellDelegate
protocol MainTableCellDelegate: AnyObject {
    func showHistoricalEventDetail(id: UUID)
}

//MARK: - MainTableCell
class MainTableCell: UITableViewCell {
    
    //MARK: - UIConstants
    struct UIConstants {
        static let headerTitleHeight: CGFloat = 32
        static let cellHeight: CGFloat = 200
    }
    
    //MARK: - Properties
    weak var delegate: MainTableCellDelegate?
    
    private var hasHeader = false
    private let titleLabel = UILabel()
    
    //MARK: - Public Methods
    func configurate(section: MainTableSectionItem, titleText: String?) {
        backgroundColor = .clear
        
        let cellViewFactory = MainTableCellViewFactory()
        let cellView: UIView
        
        switch section.type {
            case .historicalEvents:
                cellView = cellViewFactory.makeHistoricalEventCellView(items: section.items, delegate: self)
                
            case .gallery:
                cellView = cellViewFactory.makeHistoricalEventCellView(items: section.items, delegate: self)
        }
        for view in contentView.subviews {
            view.removeFromSuperview()
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

extension MainTableCell: HistoricalEventCellDelegate {
    func showDetails(id: UUID) {
        delegate?.showHistoricalEventDetail(id: id)
    }
}
