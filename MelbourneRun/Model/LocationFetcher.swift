//
//  LocationFetcher.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 23/3/21.
//

import Foundation
import CoreLocation

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    
    static let share = LocationFetcher()
    
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?

    override private init() {
        super.init()
        manager.delegate = self
        self.start()
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}
