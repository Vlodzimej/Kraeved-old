//
//  MiniAppsScreenViewController.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 24.12.2022.
//

import UIKit

// MARK: - MiniAppsScreenViewProtocol
protocol MiniAppsScreenViewProtocol: AnyObject {
}

// MARK: - MiniAppsScreenViewController
class MiniAppsScreenViewController: BaseViewController, MiniAppsScreenViewProtocol {

    // MARK: Properties
    private let presenter: MiniAppsScreenPresenterProtocol

    // MARK: UIProperties

    // MARK: Init
    init(presenter: MiniAppsScreenPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("don't use storyboards!")
    }

    // MARK: VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

    private func initialize() {
    }

    // MARK: Private methods

    // MARK: Public methods

}
