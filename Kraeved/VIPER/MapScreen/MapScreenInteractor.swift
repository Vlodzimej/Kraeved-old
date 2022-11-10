import MapKit

//MARK: - MapScreenInteractorProtocol
protocol MapScreenInteractorProtocol: AnyObject {
    func getAnnotations() async
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
    
    
    
    func getAnnotations() async {
        Task {
            let result = try await annotationManager.getAnnotations()
            await MainActor.run {
                print("TEST")
                presenter?.addAnnotations(annotations: result)
            }
        }

    }
}
