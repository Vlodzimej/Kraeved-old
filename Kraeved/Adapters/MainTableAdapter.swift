//
//  MainTableAdapter.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 20.11.2022.
//

import UIKit

//MARK: - MainTableSectionType
enum MainTableSectionType {
    case historicalEvents
    case gallery
    
    var title: String {
        switch self {
            case .historicalEvents:
                return NSLocalizedString("mainScreen.historicalEvents", comment: "")
            case .gallery:
                return NSLocalizedString("mainScreen.annotations", comment: "")
        }
    }
}

//MARK: - MainTableSectionItem
struct MainTableSectionItem {
    let type: MainTableSectionType
    var items: [MainTableCellItem] = []
    
    static func makeCellItems(from historicalEvents: [MetaObject<HistoricalEvent>]) -> [MainTableCellItem] {
        historicalEvents.map { MainTableCellItem(id: $0.id, title: $0.title, image: $0.image, text: $0.data?.text) }
    }
    
    func getImage(from url: String) {
        
    }
}

//MARK: - MainTableCellItem
struct MainTableCellItem {
    let id: UUID
    let title: String?
    let image: UIImage?
    let text: String?
}

protocol MainTableAdapterDelegate: AnyObject {
    func showHistoricalEventDetail(id: UUID)
}

class MainTableAdapter: NSObject {
    
    var sections: [MainTableSectionItem] = [
        MainTableSectionItem(type: .historicalEvents),
        MainTableSectionItem(type: .gallery)
    ]
    
    var tableView: UITableView?
    
    weak var delegate: MainTableAdapterDelegate?

    func setup(for tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude)
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
        self.tableView = tableView
    }
    
    func configure(historicalEvents: [MetaObject<HistoricalEvent>]) {
        sections.enumerated().forEach { (index, section) in
            //guard let self = self else { return }
            switch section.type {
                case .historicalEvents:
                    sections[index].items = MainTableSectionItem.makeCellItems(from: historicalEvents)
                case .gallery:
                    sections[index].items = []
         
            }
        }
        tableView?.reloadData()
    }
}

extension MainTableAdapter: UITableViewDelegate {
    
}

extension MainTableAdapter: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as? MainTableViewCell else { return UITableViewCell() }
        let titleText: String? = indexPath.item == 0 ? section.type.title : nil
        cell.configurate(section: section, titleText: titleText)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.item == 0 ? MainTableViewCell.UIConstants.cellHeight + Constants.contentInset : MainTableViewCell.UIConstants.cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        CGFloat.leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
}

extension MainTableAdapter: MainTableCellDelegate {
    func showHistoricalEventDetail(id: UUID) {
        delegate?.showHistoricalEventDetail(id: id)
    }
}
