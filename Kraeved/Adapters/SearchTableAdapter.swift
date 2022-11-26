//
//  SearchTableAdapter.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 26.11.2022.
//

import UIKit

//MARK: - SearchTableAdapterDelegate
protocol SearchTableAdapterDelegate: AnyObject {
    func showHistoricalEventDetail(id: UUID)
}

//MARK: - SearchTableAdapter
class SearchTableAdapter: NSObject {
    
    private var businessObjects: [BusinessObject] = []
    
    private var tableView: UITableView?
    
    weak var delegate: SearchTableAdapterDelegate?
    
    func setup(for tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude)
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchTableViewCell")
        self.tableView = tableView
    }
    
    func configure(businessObjects: [BusinessObject]) {
        self.businessObjects = businessObjects
        tableView?.reloadData()
    }
}

extension SearchTableAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let businessObject = businessObjects[indexPath.item]
        if businessObject.metaTypeId?.uuidString.lowercased() == MetaType.historicalEvent.rawValue.lowercased() {
            delegate?.showHistoricalEventDetail(id: businessObject.id)
        }
    }
}

extension SearchTableAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        businessObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as? SearchTableViewCell else { return UITableViewCell() }
        let businessObject = businessObjects[indexPath.item]
        cell.configurate(title: businessObject.title ?? NSLocalizedString("common.noTitle", comment: ""))
        return cell
    }
}
