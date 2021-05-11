//
//  GymPlanOrNavigationSwitchView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 10/5/21.
//
import Mapbox
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections
import Polyline
import SwiftUI

struct GymPlanOrNavigationSwitchView: View {
    @EnvironmentObject var userData:UserData
    @Binding var showSheet:Bool
    @Binding var showDirection:Bool
    @Binding var directionsRoute:Route?
    @Binding var routeOptions:RouteOptions?
    @ObservedObject var gym:GymCore
    @Binding var showPlan:Bool
    @Binding var roadSituation:RecentlyRoadSituation
    var start:String
    var close:String
    
    var body: some View {
        if self.showDirection {
                DirectionView(directionsRoute: $directionsRoute, routeOptions: $routeOptions, showNavigation: $showDirection, showSheet: $showSheet)
                    .ignoresSafeArea(.all)
                    .environmentObject(userData)
            }
        else if self.showPlan {
                PlanView(name: gym.name,address:gym.address,start:start,close:close,roadSituation: $roadSituation, isShownPlan: $showPlan, isShow:$showSheet).environmentObject(userData)
            }
            else {
                Color.clear
            }
    }
}


