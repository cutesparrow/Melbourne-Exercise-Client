//
//  testView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 16/4/21.
//

//import SwiftUI
//import MapKit
//
//
//struct testView: View {
//    
//    var body: some View {
//        MapView(coordinates: "")
//            .ignoresSafeArea(.all)
//    }
//}
//
//struct testView_Previews: PreviewProvider {
//    static var previews: some View {
//        testView()
//    }
//}
import Mapbox
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections
import SwiftUI
import UIKit
import CoreLocation
import MapKit
import Polyline


struct DirectionView: UIViewControllerRepresentable {
    func makeCoordinator() -> DirectionView.Coordinator {
        Coordinator(self)
    }

    @Binding var directionsRoute: Route?
    @Binding var routeOptions: RouteOptions?
    @Binding var showNavigation: Bool
    @Binding var showSheet:Bool

    func makeUIViewController(context: UIViewControllerRepresentableContext<DirectionView>) -> NavigationViewController {
        let navigationOptions = NavigationOptions(styles: [CustomDayStyle(),CustomNightStyle()])
        let navigationViewController = NavigationViewController(for: directionsRoute!, routeIndex: 0, routeOptions: routeOptions!,navigationOptions: navigationOptions)
        navigationViewController.delegate = context.coordinator
        navigationViewController.automaticallyAdjustsStyleForTimeOfDay = true
//        navigationViewController.modalPresentationStyle = .fullScreen
        navigationViewController.showsSpeedLimits = true
//        navigationViewController.annotatesSpokenInstructions = true
        
        return navigationViewController

    }
    
    func updateUIViewController(_ uiViewController: NavigationViewController, context: UIViewControllerRepresentableContext<DirectionView>) {
        // do nothing
    }
    
    class Coordinator: NSObject, NavigationViewControllerDelegate {
        var control: DirectionView
        
        init(_ control: DirectionView) {
            self.control = control
        }
        
        func navigationViewControllerDidDismiss(_ navigationViewController: NavigationViewController, byCanceling canceled: Bool) {
            self.control.showNavigation = false
            self.control.showSheet = false
        }
    }
}
