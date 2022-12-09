import UIKit
import MapKit

// MARK: - MapScreenPresenterProtocol
protocol MapScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func openAnnotation(annotation: Annotation)
    func addAnnotations(annotations: [Annotation])
}

// MARK: - MapScreenPresenter
class MapScreenPresenter: MapScreenPresenterProtocol {

    // MARK: Properties
    weak var view: MapScreenViewProtocol?
    private let interactor: MapScreenInteractorProtocol
    private let router: MapScreenRouterProtocol

    // MARK: Init
    init(interactor: MapScreenInteractorProtocol, router: MapScreenRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }

    func viewDidLoad() {
        guard let view = view else { return }
        let initialLocation = CLLocation(latitude: 54.5293, longitude: 36.27542)
        view.mapView.centerLocation(initialLocation)

        let cameraCenter =  CLLocation(latitude: 54.5293, longitude: 36.27542)
        let region = MKCoordinateRegion(center: cameraCenter.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        view.mapView.setRegion(region, animated: true)

        interactor.getAnnotations()
    }

    func addAnnotations(annotations: [Annotation]) {
        view?.mapView.addAnnotations(annotations)
    }

    func openAnnotation(annotation: Annotation) {
        router.openAnnotation(annotation: annotation)
    }
}
