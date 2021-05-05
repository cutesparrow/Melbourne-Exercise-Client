//
//  LocationManager.swift
//  MelbExercise
//
//  Created by gaoyu shi on 5/5/21.
//

import Foundation
import MapKit
import CoreLocation

class UserLocationManager{
    static let share = UserLocationManager()
    
    private let locationManager =  CLLocationManager()
    
    private init() {
        setupManager()
    }
    
    func setupManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    func LocationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])->CLLocationCoordinate2D {
        manager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
    }
    
    func openMapApp(destination:CLLocationCoordinate2D)->Void{
//        setupManager()
        let source = MKMapItem(placemark: MKPlacemark(coordinate: checkUserLocation(lat: LocationFetcher.share.lastKnownLocation?.latitude ?? -37.810489070978186, long: LocationFetcher.share.lastKnownLocation?.longitude ?? 144.96290632581503) ? CLLocationCoordinate2D(latitude: LocationFetcher.share.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: LocationFetcher.share.lastKnownLocation?.longitude ?? 144.96290632581503) : CLLocationCoordinate2D(latitude: -37.810489070978186, longitude: 144.96290632581503)))
        source.name = "Source"
        
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: destination.latitude, longitude:destination.longitude)))
        destination.name = "Destination"
        MKMapItem.openMaps(
            with: [source, destination],
            launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        )
    }
}
