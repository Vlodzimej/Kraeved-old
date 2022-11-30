//
//  HistoricalEventPresenter.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 23.11.2022.
//

import UIKit

//MARK: - HistoricalEventPresenterProtocol
protocol HistoricalEventPresenterProtocol: AnyObject {
    func viewDidLoad()
}

//MARK: - HistoricalEventPresenter
class HistoricalEventPresenter: HistoricalEventPresenterProtocol {

    //MARK: Properties
    weak var view: HistoricalEventViewProtocol?
    private let interactor: HistoricalEventInteractorProtocol
    private let router: HistoricalEventRouterProtocol
    
    private let id: UUID
    


    //MARK: Init
    init(interactor: HistoricalEventInteractorProtocol, router: HistoricalEventRouterProtocol, id: UUID) {
        self.router = router
        self.interactor = interactor
        self.id = id
    }
    
    func viewDidLoad() {
        interactor.getHistoricalEvent(by: id) { [weak self] result in
            guard let view = self?.view else { return }
            DispatchQueue.main.async {
                view.update(object: result)
            }
        }
    }
}
