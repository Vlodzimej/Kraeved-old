//
//  HistoricalEventInteractor.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 23.11.2022.
//

import Foundation

//MARK: - HistoricalEventInteractorProtocol
protocol HistoricalEventInteractorProtocol: AnyObject {
    func getHistoricalEvent(by id: UUID, completion: @escaping (MetaObject<HistoricalEvent>) -> Void)
}

//MARK: - HistoricalEventInteractor
class HistoricalEventInteractor: HistoricalEventInteractorProtocol {

    //MARK: Properties
    weak var presenter: HistoricalEventPresenterProtocol?
    
    private let historicalEventManager: HistoricalEventsManagerProtocol

    //MARK: Init
    init(historicalEventManager: HistoricalEventsManagerProtocol = HistoricalEventsManager.shared) {
        self.historicalEventManager = historicalEventManager
    }

    //MARK: Private Methods

    //MARK: Public Methods
    func getHistoricalEvent(by id: UUID, completion: @escaping (MetaObject<HistoricalEvent>) -> Void) {
        historicalEventManager.getHistoricalEvent(by: id) { [weak self] result in
            completion(result)
        }
    }
}
