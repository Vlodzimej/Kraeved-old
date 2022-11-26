//
//  ProfileTableViewCell.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 27.11.2022.
//

import UIKit

//MARK: - ProfileTableViewCell
class ProfileTableViewCell: UITableViewCell {
    
    //MARK: UIConstants
    struct UIConstatns {
        static let cellHeight: CGFloat = 64
        static let contentInset: CGFloat = 16
    }
    
    //MARK: UIProperties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: Private Methods
    func drawSeparator() {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: 0, y: contentView.frame.height))
        linePath.addLine(to: CGPoint(x: contentView.frame.width, y: contentView.frame.height))
        line.path = linePath.cgPath
        line.fillColor = nil
        line.opacity = 1.0
        line.strokeColor = UIColor.lightGray.cgColor
        layer.addSublayer(line)
    }
    
    //MARK: Public Methods
    func configurate(viewModel: ProfileCellViewModel, isLastRow: Bool) {
        for view in contentView.subviews {
            view.removeFromSuperview()
        }
        
        titleLabel.text = viewModel.title
        contentView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstatns.contentInset).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        valueLabel.text = viewModel.value
        contentView.addSubview(valueLabel)
        valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstatns.contentInset).isActive = true
        valueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            
        if !isLastRow {
            drawSeparator()
        }
    }
}
