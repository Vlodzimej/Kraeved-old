import Foundation

//MARK: - MainScreenInteractorProtocol
protocol MainScreenInteractorProtocol: AnyObject {
    func getHistoryEvents(completion: @escaping ([HistoryEvent]) -> Void) 
}

//MARK: - MainScreenInteractor
class MainScreenInteractor: MainScreenInteractorProtocol {

    //MARK: Properties
    weak var presenter: MainScreenPresenterProtocol?
    
    private let historyEventsManager: HistoryEventsManagerProtocol
    private let imageManager: ImageManagerProtocol

    //MARK: Init
    init(historyEventsManager: HistoryEventsManagerProtocol = HistoryEventsManager.shared, imageManager: ImageManagerProtocol = ImageManager.shared) {
        self.historyEventsManager = historyEventsManager
        self.imageManager = imageManager
    }
    
    func getHistoryEvents(completion: @escaping ([HistoryEvent]) -> Void) {
        let group = DispatchGroup()
        var events: [HistoryEvent]?
        
        group.enter()
        historyEventsManager.getHistoryEvents { result in
            events = result
            group.leave()
        }
        

        guard var events = events else { return }
        events.enumerated().forEach { [weak self] (index, event) in
            group.enter()
            guard let self = self, let imageUrl = event.imageUrl, let url = URL(string: imageUrl) else { return }
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
