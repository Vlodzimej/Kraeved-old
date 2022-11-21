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
    let items: [MainTableCellItem]
}

struct MainTableCellItem {
    let title: String
    let image: UIImage?
}

protocol MainTableDelegate: AnyObject {
    
}

class MainTableAdapter: NSObject {
    
    let sections: [MainTableSectionItem] = [
        MainTableSectionItem(type: .historicalEvents, items: [
            MainTableCellItem(title: "Title 1", image: UIImage()),
            MainTableCellItem(title: "Title 2", image: UIImage()),
            MainTableCellItem(title: "Title 3", image: UIImage()),
            MainTableCellItem(title: "Title 4", image: UIImage()),
            MainTableCellItem(title: "Title 5", image: UIImage()),
            MainTableCellItem(title: "Title 6", image: UIImage()),
        ]),
        MainTableSectionItem(type: .gallery, items: [
            MainTableCellItem(title: "Title 1", image: UIImage()),
            MainTableCellItem(title: "Title 2", image: UIImage()),
        ])
    ]
    
    func setup(for tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableCell.self, forCellReuseIdentifier: "MainTableCell")
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
        .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }
}
