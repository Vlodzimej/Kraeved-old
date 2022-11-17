import MapKit

//MARK: - MapScreenInteractorProtocol
protocol MapScreenInteractorProtocol: AnyObject {
    func getAnnotations()
}

//MARK: - MapScreenInteractor
class MapScreenInteractor: MapScreenInteractorProtocol {

    private let annotationManager: AnnotationManager
    
    private var annotations: [Annotation] = []
    
    //MARK: Properties
    weak var presenter: MapScreenPresenterProtocol?

    //MARK: Init
    init(annotationManager: AnnotationManager = AnnotationManager.shared) {
        self.annotationManager = annotationManager
    }
    
    
    func getAnnotations() {
        annotationManager.getAnnotations() { [weak self] result in
            guard let self = self else { return }
            self.presenter?.addAnnotations(annotations: result)
        }
    }
}
