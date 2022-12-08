//
//  HistoricalEventViewController.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 23.11.2022.
//

import UIKit

//MARK: - HistoricalEventViewProtocol
protocol HistoricalEventViewProtocol: AnyObject {
    func update(object: MetaObject<Entity>)
}

//MARK: - HistoricalEventViewController
class HistoricalEventViewController: BaseViewController, HistoricalEventViewProtocol {

    //MARK: Properties
    private let presenter: HistoricalEventPresenterProtocol
    
    //MARK: UIProperties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = .black
        return label
    }()
    
    //MARK: Init
    init(presenter: HistoricalEventPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("don't use storyboards!")
    }

    //MARK: VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        initialize()
        
    }

    private func initialize() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 128).isActive = true
        //titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        view.addSubview(textLabel)
        
        textLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 64).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }

    //MARK: Private methods

    //MARK: Public methods
    func update(object: MetaObject<Entity>) {
        titleLabel.text = object.title
        textLabel.text = object.data?.text
    }

}

