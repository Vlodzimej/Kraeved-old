//
//  FavoriteScreenViewController.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 22.06.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SnapKit

//MARK: - FavoriteScreenViewProtocol
protocol FavoriteScreenViewProtocol: AnyObject {
}

//MARK: - FavoriteScreenViewController
class FavoriteScreenViewController: BaseViewController, FavoriteScreenViewProtocol {

    //MARK: Properties
    private let presenter: FavoriteScreenPresenterProtocol
    
    //MARK: UIProperties
    
    //MARK: Init
    init(presenter: FavoriteScreenPresenterProtocol) {
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
    }

    private func initialize() {
    }

    //MARK: Private methods

    //MARK: Public methods

}

