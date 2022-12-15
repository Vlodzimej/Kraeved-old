import Foundation

//MARK: - SearchItem
struct SearchItem {
    let id: UUID
    let title: String
}

//MARK: - SearchScreenInteractorProtocol
protocol SearchScreenInteractorProtocol: AnyObject {
    var items: [SearchItem] { get set }
    
    func search(metaType: MetaType, searchText: String)
}

//MARK: - SearchScreenInteractor
class SearchScreenInteractor: SearchScreenInteractorProtocol {

    //MARK: Properties
    weak var presenter: SearchScreenPresenterProtocol?
    private let historicalEventsManager: HistoricalEventsManagerProtocol
    
    var items: [SearchItem] = []

    //MARK: Init
    init(historicalEventsManager: HistoricalEventsManagerProtocol = HistoricalEventsManager.shared) {
        self.historicalEventsManager = historicalEventsManager
    }
    
    func search(metaType: MetaType, searchText: String) {
        historicalEventsManager.find(title: searchText) { [weak self] metaObjects in
            guard let self = self else { return }
            self.items = metaObjects.compactMap { item in
                guard let title = item.title else { return nil }
                return SearchItem(id: item.id, title: title)
            }
            self.presenter?.update()
        }
    }
}
