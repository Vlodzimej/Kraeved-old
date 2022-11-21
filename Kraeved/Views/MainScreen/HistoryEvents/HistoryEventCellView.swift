//
//  HistoryEventCell.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 20.11.2022.
//

import UIKit

class HistoryEventCellView: UIView {
    
    private let items: [MainTableCellItem]
    
    init(items: [MainTableCellItem]) {
        self.items = items
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var collecttionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        
        collectionView.register(HistoryEventCollectionCell.self, forCellWithReuseIdentifier: "HistoryEventCollectionCell")
        return collectionView
    }()
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let itemsSpacing: CGFloat = 16
        layout.minimumLineSpacing = itemsSpacing
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private func initialize() {
        translatesAutoresizingMaskIntoConstraints = false
        collecttionView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .clear
        
        addSubview(collecttionView)
        collecttionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        collecttionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collecttionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        collecttionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}


extension HistoryEventCellView: UICollectionViewDataSource {
    
    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistoryEventCollectionCell", for: indexPath) as? HistoryEventCollectionCell else {
            return UICollectionViewCell()
        }
        let item = items[indexPath.item]
        cell.configurate(title: item.title, image: item.image)
        
        return cell
    }
}
extension HistoryEventCellView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HistoryEventCellView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let numberOfItemsPerRow: CGFloat = 3
        let spacing: CGFloat = flowLayout.minimumInteritemSpacing
        let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
        let itemDimension = floor(availableWidth / numberOfItemsPerRow)
        return CGSize(width: itemDimension, height: itemDimension)
    }
}
