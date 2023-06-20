//
//  MainTableCell.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 20.11.2022.
//

import UIKit
import SnapKit

// MARK: - MainTableCellDelegate
protocol MainTableCellDelegate: AnyObject {
    func showEntityDetails(id: UUID)
}

// MARK: - MainTableCell
final class MainTableViewCell: UITableViewCell {

    // MARK: UIConstants
    struct UIConstants {
        static let headerTitleHeight: CGFloat = 32
        static let cellHeight: CGFloat = 200
        static let titleLabelFontSize: CGFloat = 14
    }

    // MARK: - Properties
    weak var delegate: MainTableCellDelegate?

    private let titleLabel = UILabel()
    
    private let separatorView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.MainScreen.entityCollectionSeparator
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var cellView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        cellView.backgroundColor = .red
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { maker in
            maker.top.width.equalToSuperview()
            maker.leading.equalToSuperview().inset(Constants.contentInset + 16)
        }
        
        contentView.addSubview(separatorView)
        separatorView.snp.makeConstraints { maker in
            maker.top.equalTo(titleLabel.snp.bottom).offset(-8)
            maker.height.equalTo(24)
            maker.leading.equalToSuperview().offset(Constants.contentInset)
            maker.width.equalTo(140)
        }
        
        contentView.addSubview(cellView)
        cellView.snp.makeConstraints { maker in
            maker.top.equalTo(separatorView.snp.bottom)
            maker.bottom.leading.trailing.equalToSuperview()
        }
    }

    // MARK: - Public Methods
    func configurate(section: MainTableSectionItem, titleText: String?, hasOverlay: Bool = false) {
        backgroundColor = .clear

        let cellViewFactory = MainTableCellViewFactory()
        switch section.type {
            case .historicalEvent:
                cellView = cellViewFactory.makeHistoricalEventCellView(items: section.items, delegate: self)
            case .annotation:
                cellView = cellViewFactory.makeLocationsCellView(items: section.items, delegate: self)
            case .photo:
                cellView = cellViewFactory.makeGalleryCellView(items: section.items, delegate: self)
        }
        
        if let titleText {
            titleLabel.attributedText = NSAttributedString(string: titleText, attributes: [.font: UIFont.BeVietnamPro.Regular(withSize: UIConstants.titleLabelFontSize), .foregroundColor: UIColor.HEX.h1A8F8F])
        }
        
        cellView.setNeedsDisplay()

        
//        cellView.snp.remakeConstraints { maker in
//            maker.top.equalTo(separatorView.snp.bottom)
//            maker.bottom.leading.trailing.equalToSuperview()
//        }
    }
}

// MARK: - MainTableViewCell
extension MainTableViewCell: EntityCellDelegate {
    func showDetails(id: UUID) {
        delegate?.showEntityDetails(id: id)
    }
}
