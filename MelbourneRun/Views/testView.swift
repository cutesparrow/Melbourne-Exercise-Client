//
//  testView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 16/4/21.
//

import SwiftUI
import MapKit

extension Map {
    func mapStyle(_ mapType: MKMapType) -> some View {
        MKMapView.appearance().mapType = mapType
        return self
    }
    
    func mapStyle(_ mapType: MKMapType, showScale: Bool = true, showTraffic: Bool = false) -> some View {
            let map = MKMapView.appearance()
            map.mapType = mapType
            map.showsScale = showScale
            map.showsTraffic = showTraffic
            return self
        }
}



struct testView: View {
    @State private var coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.7, longitude: -73.9), span: MKCoordinateSpan(latitudeDelta: 100.0, longitudeDelta: 100.0))
    
   
    
    var body: some View {
        Map(coordinateRegion: $coordinateRegion).mapStyle(.standard, showScale: false, showTraffic: false)
    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView()
    }
}
