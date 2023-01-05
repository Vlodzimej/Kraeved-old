//
//  MiniAppsAdapter.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 05.01.2023.
//

import UIKit

struct MiniAppViewModel {
    let title: String
    let image: UIImage?
}

protocol MiniaAppCollectionAdapterDelegate: AnyObject {
    func showMessage()
}

protocol MiniAppCollectionAdapterProtocol: AnyObject, UICollectionViewDelegate {
    var delegate: MiniaAppCollectionAdapterDelegate? { get set }
    
    func setup(collectionView: UICollectionView)
}

class MiniAppCollectionAdapter: NSObject, MiniAppCollectionAdapterProtocol {
    
    private var collectionView: UICollectionView?
    weak var delegate: MiniaAppCollectionAdapterDelegate?
    
    private let items: [MiniAppViewModel] = [
        .init(title: "Мои записи", image: UIImage.MiniApps.notes),
        .init(title: "Генеалогия", image: UIImage.MiniApps.genealogy),
        .init(title: "Приюты для животных", image: UIImage.MiniApps.shelter),
        .init(title: "Развитие", image: UIImage.MiniApps.education)
    ]
    
    func setup(collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MiniAppCollectionCell.self, forCellWithReuseIdentifier: "MiniAppCollectionViewCell")
        self.collectionView = collectionView
    }
}

extension MiniAppCollectionAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MiniAppCollectionViewCell", for: indexPath) as? MiniAppCollectionCell else {
            return UICollectionViewCell()
        }
        
        guard let item = items[safeIndex: indexPath.row] else {
            return cell
        }
        
        cell.configurate(title: item.title, image: item.image)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: Constants.contentInset, left: Constants.contentInset, bottom: Constants.contentInset, right: Constants.contentInset)
    }
}

extension MiniAppCollectionAdapter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.showMessage()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MiniAppCollectionAdapter: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let numberOfItemsPerRow = 4.0
        let itemDimension = floor(width / numberOfItemsPerRow)
        return CGSize(width: itemDimension, height: itemDimension + 64)
    }
}
