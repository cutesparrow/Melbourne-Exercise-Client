//
//  LocationMapView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 18/3/21.
//

import SwiftUI
import MapKit

struct MyAnnotationItem: Identifiable {
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
}

struct LocationMapView: View {
    @State var location:MKCoordinateRegion
    var annotationItems:[MyAnnotationItem]
    init(lat:Double,long:Double) {
        _location = .init(initialValue:getMK(lat: lat, long: long))
        annotationItems = [
              MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long))
          ]
    }
    var body: some View {
        Map(coordinateRegion: $location, annotationItems: annotationItems){ place in
            MapMarker(coordinate: place.coordinate)
            
        }
        
            
    }
}

struct LocationMapView_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapView(lat: 34, long: 33)
    }
}
