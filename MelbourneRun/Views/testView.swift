//
//  testView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 16/4/21.
//

import SwiftUI
import MapKit

struct testView: View {
    @State private var coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.7, longitude: -73.9), span: MKCoordinateSpan(latitudeDelta: 100.0, longitudeDelta: 100.0))
    
    init() {
        MKMapView.appearance().mapType = .satellite
    }
    
    @ViewBuilder var body: some View {
        Map(coordinateRegion: $coordinateRegion)
    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView()
    }
}
