import MapKit

// MARK: - MapScreenInteractorProtocol
protocol MapScreenInteractorProtocol: AnyObject {
    func getAnnotations()
    func getEntity(id: UUID, completion: @escaping (MetaObject<Entity>) -> Void)
}

// MARK: - MapScreenInteractor
class MapScreenInteractor: MapScreenInteractorProtocol {

    private let annotationManager: AnnotationManagerProtocol
    private let entityManager: EntityManagerProtocol

    private var annotations: [Annotation] = []

    // MARK: Properties
    weak var presenter: MapScreenPresenterProtocol?

    // MARK: Init
    init(annotationManager: AnnotationManagerProtocol = AnnotationManager.shared, entityManager: EntityManagerProtocol = EntityManager.shared) {
        self.annotationManager = annotationManager
        self.entityManager = entityManager
    }

    // MARK: Public Methods
    func getAnnotations() {
        annotationManager.getAnnotations { [weak self] annotations in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.presenter?.addAnnotations(annotations: annotations)
            }
        }
    }

    func getEntity(id: UUID, completion: @escaping (MetaObject<Entity>) -> Void) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            self.entityManager.getEntity(id: id) { entities in
                completion(entities)
            }
        }
    }
}
