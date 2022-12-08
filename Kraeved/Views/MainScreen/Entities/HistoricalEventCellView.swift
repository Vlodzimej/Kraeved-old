//
//  HistoricalEventCell.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 20.11.2022.
//

import UIKit

protocol HistoricalEventCellDelegate: AnyObject {
    func showDetails(id: UUID)
}

protocol HistoricalEventCellViewProtocol {
    var delegate: HistoricalEventCellDelegate? { get set }
}

//MARK: - HistoricalEventCellView
class HistoricalEventCellView: UIView {
    
    //MARK: - Properties
    weak var delegate: HistoricalEventCellDelegate?

    private let items: [MainTableCellItem]
    
    //MARK: - UIProperties
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HistoricalEventCollectionCell.self, forCellWithReuseIdentifier: "HistoricalEventCollectionCell")
        return collectionView
    }()
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let itemsSpacing: CGFloat = 16
        layout.minimumLineSpacing = itemsSpacing
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    //MARK: - Init
    init(items: [MainTableCellItem]) {
        self.items = items
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    private func initialize() {
        translatesAutoresizingMaskIntoConstraints = false

        backgroundColor = .clear
        
        addSubview(collectionView)
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}

//MARK: - UICollectionViewDataSource
extension HistoricalEventCellView: UICollectionViewDataSource {
    
    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count > 0 ? items.count : 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistoricalEventCollectionCell", for: indexPath) as? HistoricalEventCollectionCell else {
            return UICollectionViewCell()
        }
        guard let item = items[safeIndex: indexPath.item] else {
            cell.startAnimating()
            return cell
        }
        cell.configurate(title: item.title, image: item.image)
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension HistoricalEventCellView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let historicalEvent = items[indexPath.item]
        delegate?.showDetails(id: historicalEvent.id)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HistoricalEventCellView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: Constants.contentInset, left: Constants.contentInset, bottom: Constants.contentInset, right: Constants.contentInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let numberOfItemsPerRow: CGFloat = 2.5
        let spacing: CGFloat = flowLayout.minimumInteritemSpacing
        let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
        let itemDimension = floor(availableWidth / numberOfItemsPerRow)
        return CGSize(width: itemDimension, height: itemDimension)
    }
}
