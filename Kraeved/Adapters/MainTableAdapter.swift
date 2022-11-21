//
//  MainTableAdapter.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 20.11.2022.
//

import UIKit

enum MainTableSectionType {
    case historicalEvents
    case gallery
    
    var title: String {
        switch self {
            case .historicalEvents:
                return "События в этот день"
            case .gallery:
                return "Галлерея"
        }
    }
}

struct MainTableSectionItem {
    let type: MainTableSectionType
    var items: [MainTableCellItem] = []
    
    static func makeCellItems(from historyEvents: [HistoryEvent]) -> [MainTableCellItem] {
        historyEvents.map { MainTableCellItem(title: $0.title, image: $0.image, text: $0.text) }
    }
    
    func getImage(from url: String) {
        
    }
}

struct MainTableCellItem {
    let title: String?
    let image: UIImage?
    let text: String?
}

protocol MainTableDelegate: AnyObject {
    
}

class MainTableAdapter: NSObject {
    
    var sections: [MainTableSectionItem] = [
        MainTableSectionItem(type: .historicalEvents),
        MainTableSectionItem(type: .gallery)
    ]
    
    var tableView: UITableView?

    func setup(for tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude)
        tableView.register(MainTableCell.self, forCellReuseIdentifier: "MainTableCell")
        self.tableView = tableView
    }
    
    func configure(historyEvents: [HistoryEvent]) {
        sections.enumerated().forEach { (index, section) in
            //guard let self = self else { return }
            switch section.type {
                case .historicalEvents:
                    sections[index].items = MainTableSectionItem.makeCellItems(from: historyEvents)
                case .gallery:
                sections[index].items = MainTableSectionItem.makeCellItems(from: historyEvents)
         
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableCell") as? MainTableCell else { return UITableViewCell() }
        let titleText: String? = indexPath.item == 0 ? section.type.title : nil
        cell.configurate(section: section, titleText: titleText)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.item == 0 ? MainTableCell.UIConstants.cellHeight + Constants.contentInset : MainTableCell.UIConstants.cellHeight
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
