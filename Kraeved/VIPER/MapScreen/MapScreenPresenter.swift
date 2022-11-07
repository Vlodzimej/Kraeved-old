import UIKit
import MapKit

//MARK: - MapScreenPresenterProtocol
protocol MapScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func openAnnotation(annotation: Annotation)
}

//MARK: - MapScreenPresenter
class MapScreenPresenter: MapScreenPresenterProtocol {

    //MARK: Properties
    weak var view: MapScreenViewProtocol?
    private let interactor: MapScreenInteractorProtocol
    private let router: MapScreenRouterProtocol

    //MARK: Init
    init(interactor: MapScreenInteractorProtocol, router: MapScreenRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        guard let view = view else { return }
        let initialLocation = CLLocation(latitude: 54.5293, longitude: 36.27542)
        view.mapView.centerLocation(initialLocation)
        
        let cameraCenter =  CLLocation(latitude: 54.5293, longitude: 36.27542)
        let region = MKCoordinateRegion(center: cameraCenter.coordinate, latitudinalMeters: 50000, longitudinalMeters: 50000)
        guard let cameraBondary = MKMapView.CameraBoundary(coordinateRegion: region) else { return }
        view.mapView.setCameraBoundary(cameraBondary, animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 100000)
        view.mapView.setCameraZoomRange(zoomRange, animated: true)
        
        let annotations: [Annotation] = [
            .init(coordinate: CLLocationCoordinate2D(latitude: 54.513974779803796, longitude: 36.263196462037726), title: "Кинотеатр «Центральный»", subtitle: nil)
        ]
        view.mapView.addAnnotations(annotations)
    }
    
    func openAnnotation(annotation: Annotation) {
        router.openAnnotation(annotation: annotation)
    }
}
