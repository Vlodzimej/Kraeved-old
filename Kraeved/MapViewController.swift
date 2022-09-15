//
//  MapViewController.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 29.06.2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    var mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        mapView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        let initialLocation = CLLocation(latitude: 54.5293, longitude: 36.27542)
        mapView.centerLocation(initialLocation)
        
        let cameraCenter =  CLLocation(latitude: 54.5293, longitude: 36.27542)
        let region = MKCoordinateRegion(center: cameraCenter.coordinate, latitudinalMeters: 50000, longitudinalMeters: 50000)
        guard let cameraBondary = MKMapView.CameraBoundary(coordinateRegion: region) else { return }
        mapView.setCameraBoundary(cameraBondary, animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 100000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
        
        //let KC = Places(title: "Кинотеатр Центральный", locationName: <#T##String?#>, discipline: <#T##String?#>, coordinate: <#T##CLLocationCoordinate2D#>)
    }
}

extension MKMapView {
    func centerLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
