import Foundation

//MARK: - MainScreenInteractorProtocol
protocol MainScreenInteractorProtocol: AnyObject {
    func getHistoricalEvents(completion: @escaping ([MetaObject<Entity>]) -> Void)
}

//MARK: - MainScreenInteractor
class MainScreenInteractor: MainScreenInteractorProtocol {
    
    //MARK: Properties
    weak var presenter: MainScreenPresenterProtocol?
    
    private let entityManager: EntityManagerProtocol
    private let imageManager: ImageManagerProtocol
    
    //MARK: Init
    init(entityManager: EntityManagerProtocol = EntityManager.shared, imageManager: ImageManagerProtocol = ImageManager.shared) {
        self.entityManager = entityManager
        self.imageManager = imageManager
    }
    
    func getHistoricalEvents(completion: @escaping ([MetaObject<Entity>]) -> Void) {
        var events: [MetaObject<Entity>] = []
        
        let queue = DispatchQueue(label: "ru.kraeved.concurrent-queue", attributes: .concurrent)
        let group = DispatchGroup()
        let lock = NSLock()
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.entityManager.get { responseEntities in
                responseEntities.enumerated().forEach({ [weak self] (index, entity) in
                    group.enter()
                    queue.async {
                        guard let self = self, let imageUrl = entity.data?.imageUrl, let url = URL(string: imageUrl) else { return }
                        self.imageManager.downloadImage(from: url) { image in
                            let resultEntity = MetaObject<Entity>(id: entity.id, title: entity.title, image: image, data: entity.data)
                            lock.lock()
                            events.append(resultEntity)
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
