//
//  LocationViewModel.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 19/3/21.
//

import MapKit
import SwiftUI
import Polyline

class LocationViewModel: ObservableObject {
    
    var locations = [CLLocationCoordinate2D]()
    
    func load(coordinates:[Coordinate]) {
        var locations:[CLLocationCoordinate2D] = []
        for i in coordinates{
            locations.append(i.locationCoordinate())
        }
        fetchLocations(coordinates: locations)
    }
    
    private func fetchLocations(coordinates:[CLLocationCoordinate2D]) {
        let coordinates = coordinates
        
        let line = Polyline(coordinates: coordinates)
        let encodedPolyline: String = line.encodedPolyline
        
        let polyline = Polyline(encodedPolyline: encodedPolyline)
        guard let decodedLocations = polyline.locations else { return }
        locations = decodedLocations.map { CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)}
    }
}



final class MapViewCoordinator: NSObject, MKMapViewDelegate {
    private let map: MapView
    
    init(_ control: MapView) {
        self.map = control
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        if let annotationView = views.first, let annotation = annotationView.annotation {
            if annotation is MKUserLocation {
                let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 700, longitudinalMeters: 700)
                mapView.setRegion(region, animated: true)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor(Color.blue.opacity(0.7))
        renderer.lineWidth = 10.0
        renderer.fillColor = UIColor.black
        return renderer
    }
}
