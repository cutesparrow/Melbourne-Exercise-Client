//
//  MapView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 9/3/21.
//

import SwiftUI
import MapKit
import Polyline

struct MapView: UIViewRepresentable {
    var polyline:[CLLocationCoordinate2D]?
   
    private let mapZoomEdgeInsets = UIEdgeInsets(top: 30.0, left: 30.0, bottom: 30.0, right: 30.0)
    
    init(polyline:String) {
        self.polyline = Polyline(encodedPolyline: polyline).coordinates
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: UIScreen.main.bounds)
       
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.isUserInteractionEnabled = true
        mapView.showsUserLocation = true
//        mapView.centerCoordinate = CLLocationCoordinate2D(latitude: -37.81048913607042, longitude: 144.962441682062)
        mapView.delegate = context.coordinator
        let centerButton = MKUserTrackingButton(mapView: mapView)
        centerButton.frame.origin.y = UIScreen.main.bounds.height - 80
        centerButton.frame.origin.x = UIScreen.main.bounds.width - 80
        mapView.insertSubview(centerButton, at: 1)
        
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        updateOverlays(from: uiView)
        
    }
    
    private func updateOverlays(from mapView: MKMapView) {
        mapView.removeOverlays(mapView.overlays)
        let polyline = MKPolyline(coordinates: self.polyline!, count: self.polyline!.count)
        mapView.addOverlay(polyline)
        setMapZoomArea(map: mapView, polyline: polyline, edgeInsets: mapZoomEdgeInsets, animated: true)
    }
    
    private func setMapZoomArea(map: MKMapView, polyline: MKPolyline, edgeInsets: UIEdgeInsets, animated: Bool = false) {
        map.setVisibleMapRect(polyline.boundingMapRect, edgePadding: edgeInsets, animated: animated)
        DispatchQueue.main.async {
        map.userTrackingMode = .followWithHeading
        }
    }
}



