//
//  MapView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 9/3/21.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var coordinates:[CLLocationCoordinate2D]
    private let locationViewModel = LocationViewModel()
    private let mapZoomEdgeInsets = UIEdgeInsets(top: 30.0, left: 30.0, bottom: 30.0, right: 30.0)
    
    init(coordinates:[CLLocationCoordinate2D]) {
        self.coordinates = coordinates
        locationViewModel.load(coordinates: coordinates)
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        updateOverlays(from: uiView)
    }
    
    private func updateOverlays(from mapView: MKMapView) {
        mapView.removeOverlays(mapView.overlays)
        let polyline = MKPolyline(coordinates: locationViewModel.locations, count: locationViewModel.locations.count)
        mapView.addOverlay(polyline)
        setMapZoomArea(map: mapView, polyline: polyline, edgeInsets: mapZoomEdgeInsets, animated: true)
    }
    
    private func setMapZoomArea(map: MKMapView, polyline: MKPolyline, edgeInsets: UIEdgeInsets, animated: Bool = false) {
        map.setVisibleMapRect(polyline.boundingMapRect, edgePadding: edgeInsets, animated: animated)
    }
}


struct MapView_Previews: PreviewProvider {
    static let data = UserData()
    static var previews: some View {
        MapView(coordinates: [CLLocationCoordinate2D(latitude: -37.81228028830977, longitude: 144.96229225616813),
                              CLLocationCoordinate2D(latitude: -37.816196112093316, longitude: 144.96404105636753),CLLocationCoordinate2D(latitude: -37.81470439418989, longitude: 144.96899777840505)])
            
    }
}
