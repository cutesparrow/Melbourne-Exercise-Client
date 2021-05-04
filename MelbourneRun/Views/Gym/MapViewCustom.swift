//
//  MapViewCustom.swift
//  MelbExercise
//
//  Created by gaoyu shi on 4/5/21.
//

import SwiftUI
import MapKit

struct MapViewCustom: View {
    @Binding var coordinateRegion:MKCoordinateRegion
        
    init(region:Binding<MKCoordinateRegion>) {
        MKMapView.appearance().mapType = .satellite
            self._coordinateRegion = region
            
        }
        
        @ViewBuilder var body: some View {
            Map(coordinateRegion: $coordinateRegion)
        }
}


