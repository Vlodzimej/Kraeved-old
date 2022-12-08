import Foundation

//MARK: - MainScreenInteractorProtocol
protocol MainScreenInteractorProtocol: AnyObject {
    func getHistoricalEvents(completion: @escaping ([MetaObject<Entity>]) -> Void)
}

//MARK: - MainScreenInteractor
class MainScreenInteractor: MainScreenInteractorProtocol {
    
    //MARK: Properties
    weak var presenter: MainScreenPresenterProtocol?
    
    private let historicalEventsManager: EntityManagerProtocol
    private let imageManager: ImageManagerProtocol
    
    //MARK: Init
    init(historicalEventsManager: EntityManagerProtocol = EntityManager.shared, imageManager: ImageManagerProtocol = ImageManager.shared) {
        self.historicalEventsManager = historicalEventsManager
        self.imageManager = imageManager
    }
    
    func getHistoricalEvents(completion: @escaping ([MetaObject<Entity>]) -> Void) {
        var events: [MetaObject<Entity>] = []
        
        let queue = DispatchQueue(label: "ru.kraeved.concurrent-queue", attributes: .concurrent)
        let group = DispatchGroup()
        let lock = NSLock()
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.historicalEventsManager.get { responseEvents in
                responseEvents.enumerated().forEach({ [weak self] (index, event) in
                    group.enter()
                    queue.async {
                        guard let self = self, let imageUrl = event.data?.imageUrl, let url = URL(string: imageUrl) else { return }
                        self.imageManager.downloadImage(from: url) { image in
                            let resultEvent = MetaObject<Entity>(id: event.id, title: event.title, image: image, data: event.data)
                            lock.lock()
                            events.append(resultEvent)
                            lock.unlock()
                            group.leave()
                        }
                    }
                })
                queue.async {
                    group.wait()
                    completion(events)
                }
            }
        }

    }
}
