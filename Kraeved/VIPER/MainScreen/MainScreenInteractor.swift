import Foundation

//MARK: - MainScreenInteractorProtocol
protocol MainScreenInteractorProtocol: AnyObject {
    func getHistoricalEvents(completion: @escaping ([MetaObject<HistoricalEventData>]) -> Void)
}

//MARK: - MainScreenInteractor
class MainScreenInteractor: MainScreenInteractorProtocol {

    //MARK: Properties
    weak var presenter: MainScreenPresenterProtocol?
    
    private let historicalEventsManager: HistoricalEventsManagerProtocol
    private let imageManager: ImageManagerProtocol

    //MARK: Init
    init(historicalEventsManager: HistoricalEventsManagerProtocol = HistoricalEventsManager.shared, imageManager: ImageManagerProtocol = ImageManager.shared) {
        self.historicalEventsManager = historicalEventsManager
        self.imageManager = imageManager
    }
    
    func getHistoricalEvents(completion: @escaping ([MetaObject<HistoricalEventData>]) -> Void) {
        let group = DispatchGroup()
        var events: [MetaObject<HistoricalEventData>]?
        
        group.enter()
        historicalEventsManager.getHistoricalEvents { result in
            events = result
            group.leave()
        }
        

        guard var events = events else { return }
        
        events.enumerated().forEach { [weak self] (index, event) in
            group.enter()
            guard let self = self, let imageUrl = event.data?.imageUrl, let url = URL(string: imageUrl) else { return }
            self.imageManager.downloadImage(from: url) { result in
                events[index].image = result
                group.leave()
            }
        }

        group.notify(queue: .main) {
            print("All requests completed")
            completion(events)
        }
    }
}
