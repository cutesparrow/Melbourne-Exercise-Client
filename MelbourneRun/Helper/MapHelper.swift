//
//  MapHelper.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 18/3/21.
//

import Foundation
import CoreLocation
import MapKit

func getMK(lat:Double, long: Double)->MKCoordinateRegion{
    return MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: lat, longitude: long),
        span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
    )
}


struct Coordinate: Codable {
    let latitude: Double
    let longitude: Double

    func locationCoordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude,
                                      longitude: self.longitude)
    }
}
