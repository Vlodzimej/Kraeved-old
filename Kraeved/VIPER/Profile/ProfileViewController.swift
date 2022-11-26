//
//  ProfileViewController.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 27.11.2022.
//

import UIKit

//MARK: - ProfileViewProtocol
protocol ProfileViewProtocol: AnyObject {
    var tableView: UITableView { get set }
}

//MARK: - ProfileViewController
class ProfileViewController: BaseViewController, ProfileViewProtocol {

    //MARK: Properties
    private let presenter: ProfilePresenterProtocol
    
    //MARK: UIProperties
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    //MARK: Init
    init(presenter: ProfilePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("don't use storyboards!")
    }

    //MARK: VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        presenter.viewDidLoad()
    }

    private func initialize() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.contentInset).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.contentInset).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    //MARK: Private methods

    //MARK: Public methods

}

