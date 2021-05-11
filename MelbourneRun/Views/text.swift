//
//  text.swift
//  MelbExercise
//
//  Created by gaoyu shi on 8/5/21.
//

import SwiftUI
import MapKit
import CoreLocation
import Mapbox
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections
import Polyline

struct text: View {
    @State var route:RouteResponseCus?
    @State var finished:Bool = false
    func getRoute(location:CLLocationCoordinate2D,vehicle:String,distance:Double,seed:Int,key:String){
        let comletion:(Result<RouteResponseCus, Error>) -> Void = { result in
            switch result {
            case let .success(route):
                self.route = route
//                var routeSteps:[RouteStep]
//
//                var routeLegs:[RouteLeg]
//                for i in route.routes.first?.legs{
//                    routeLeg = RouteLeg(steps: [RouteStep], name: <#T##String#>, distance: <#T##CLLocationDistance#>, expectedTravelTime: <#T##TimeInterval#>, profileIdentifier: <#T##DirectionsProfileIdentifier#>)
//                }
                
                
                self.finished = true
                print("finished")
            case let .failure(error):print(error)
            }
            
        }
        
        _ = NetworkAPI.loadRouteObject(location: location, vehicle: vehicle, distance: distance, seed: seed, key: key,completion: comletion)
    }
    
    
    var body: some View {
//        let routeSelf:Route = Route(legs: [RouteLeg(], shape: <#T##LineString?#>, distance: <#T##CLLocationDistance#>, expectedTravelTime: <#T##TimeInterval#>)
        Button(action: {
            getRoute(location: CLLocationCoordinate2D(latitude: -37.80975580663089, longitude: 144.9637810681766), vehicle: "bike", distance: 4, seed: 364952692303910, key: "7d0ab65a-1fa0-4a8f-abb4-75be7a855ade")
        }, label: {
            Text("Button")
        })
    }
}

struct text_Previews: PreviewProvider {
    static var previews: some View {
        text()
    }
}
