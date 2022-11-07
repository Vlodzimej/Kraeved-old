import UIKit
import MapKit

//MARK: - MapScreenViewProtocol
protocol MapScreenViewProtocol: AnyObject {
    var mapView: MKMapView { get set }
}

//MARK: - MapScreenViewController
class MapScreenViewController: UIViewController, MapScreenViewProtocol {
    var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    //MARK: Properties
    private let presenter: MapScreenPresenterProtocol
    
    //MARK: UIProperties
    
    //MARK: Init
    init(presenter: MapScreenPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("don't use storyboards!")
    }

    //MARK: VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        
        presenter.viewDidLoad()
        mapView.delegate = self
    }

    private func initialize() {
        view.addSubview(mapView)
        
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

}

extension MapScreenViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        guard let annotation = annotation as? Annotation else { return }
        presenter.openAnnotation(annotation: annotation)
    }
}
