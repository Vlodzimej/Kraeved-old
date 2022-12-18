//
//  MKMapView+centerLocation.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 01.11.2022.
//

import MapKit

extension MKMapView {
    func centerLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
