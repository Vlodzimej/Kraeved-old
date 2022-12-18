import UIKit
import MapKit

// MARK: - MapScreenPresenterProtocol
protocol MapScreenPresenterProtocol: AnyObject, MKMapViewDelegate {
    func viewDidLoad()
    func openAnnotation(annotation: Annotation)
    func addAnnotations(annotations: [Annotation])
}

// MARK: - MapScreenPresenter
class MapScreenPresenter: NSObject, MapScreenPresenterProtocol {

    // MARK: Constants
    private struct Constants {
        static let startLocation = CLLocation(latitude: 54.51707774498945, longitude: 36.23049989395381)
    }
    // MARK: Properties
    weak var view: MapScreenViewProtocol?
    private let interactor: MapScreenInteractorProtocol
    private let router: MapScreenRouterProtocol
    private let locationManager = CLLocationManager()

    var selectedLocation: Annotation?

    // MARK: Init
    init(interactor: MapScreenInteractorProtocol, router: MapScreenRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
    func viewDidLoad() {
        guard let view = view else { return }

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        view.mapView.showsUserLocation = true

        let cameraCenter = Constants.startLocation
        let region = MKCoordinateRegion(center: cameraCenter.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        view.mapView.setRegion(region, animated: true)
        interactor.getAnnotations()
    }
    func addAnnotations(annotations: [Annotation]) {
        view?.mapView.addAnnotations(annotations)
    }
    func openAnnotation(annotation: Annotation) {
        interactor.getEntity(id: annotation.id) { [weak self] entity in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.view?.showLocationDetails(entity: entity)
            }
        }
    }
}

extension MapScreenPresenter: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard let view = view, let annotation = annotation as? Annotation else { return nil }

        let markerView: MKMarkerAnnotationView

        if let dequeueView = view.mapView.dequeueReusableAnnotationView(withIdentifier: "locations") as? MKMarkerAnnotationView {
            dequeueView.annotation = annotation
            markerView = dequeueView
        } else {
            markerView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "locations")
            markerView.canShowCallout = true
            markerView.calloutOffset = CGPoint(x: -5, y: 5)
            markerView.leftCalloutAccessoryView = UIImageView(image: UIImage.Common.location)
        }
        return markerView
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {

    }
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        guard let annotation = annotation as? Annotation else { return }
        openAnnotation(annotation: annotation)
    }
}

extension MapScreenPresenter: CLLocationManagerDelegate {

}
