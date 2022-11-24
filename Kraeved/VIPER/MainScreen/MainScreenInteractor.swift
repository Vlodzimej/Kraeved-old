import Foundation

//MARK: - MainScreenInteractorProtocol
protocol MainScreenInteractorProtocol: AnyObject {
    func getHistoricalEvents(completion: @escaping ([MetaObject<HistoricalEvent>]) -> Void)
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
    
    func getHistoricalEvents(completion: @escaping ([MetaObject<HistoricalEvent>]) -> Void) {
        var events: [MetaObject<HistoricalEvent>] = []
        let concurrentQueue = DispatchQueue(label: "ru.kraeved.concurrent-queue", attributes: .concurrent)
        let group = DispatchGroup()
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            group.enter()
            self?.historicalEventsManager.getHistoricalEvents { responseEvents in
                responseEvents.enumerated().forEach({ [weak self] (index, event) in
                    let workItem = DispatchWorkItem {
                        guard let self = self, let imageUrl = event.data?.imageUrl, let url = URL(string: imageUrl) else { return }
                        self.imageManager.downloadImage(from: url) { responseImage in
                            var resultEvent = event
                            resultEvent.image = responseImage
                            events.append(resultEvent)
                            group.leave()
                        }
                    }
                    group.enter()
                    concurrentQueue.async(execute: workItem)
                })
                group.leave()
            }
            group.notify(queue: DispatchQueue.main) {
                completion(events)
            }
            
        }
    }
}
