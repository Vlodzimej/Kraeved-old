//
//  ProfilePresenter.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 27.11.2022.
//

import UIKit

//MARK: - ProfilePresenterProtocol
protocol ProfilePresenterProtocol: AnyObject {
    func viewDidLoad()
}

//MARK: - ProfilePresenter
class ProfilePresenter: ProfilePresenterProtocol {

    //MARK: Properties
    weak var view: ProfileViewProtocol?
    private let interactor: ProfileInteractorProtocol
    private let router: ProfileRouterProtocol
    
    private let adapter = ProfileTableAdapter()

    //MARK: Init
    init(interactor: ProfileInteractorProtocol, router: ProfileRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        guard let view = view else { return }
        adapter.setup(tableView: view.tableView)
        adapter.configurate(user: interactor.defaultUser)
    }
}
