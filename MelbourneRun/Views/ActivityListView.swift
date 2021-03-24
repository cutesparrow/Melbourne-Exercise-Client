//
//  ActivityListView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 14/3/21.
//

import SwiftUI
import MapKit
import PermissionsSwiftUI

struct ActivityListView: View {
    
    @EnvironmentObject var userData:UserData
    @ObservedObject var locationManager = LocationManager()
    var activities:[Activity]
    var body: some View {
        ZStack{
            NavigationView{
                VStack{
                    Text("Melbourne Exercise")
                        .font(.title2)
                        .bold()
                        .frame(width: 300, height: 100, alignment: .center)
                        .foregroundColor(.blue)
                    VStack(alignment: .center, spacing: 30){
                        NavigationLink(
                            destination: HikingHomeView().environmentObject(userData),
                            label: {
                                ActivityView(activity:activities[0])
                            })
                        NavigationLink(
                            destination: GymHomeView().environmentObject(userData),
                            label: {
                                ActivityView(activity:activities[1])
                            })
                        NavigationLink(
                            destination: WalkDogHomeView().environmentObject(userData),
                            label: {
                                ActivityView(activity:activities[2])
                            })
                        NavigationLink(
                            destination: MapMainView()
                                .environmentObject(userData),
                            label: {
                                ActivityView(activity:activities[3])
                            })
                    }
                    Spacer()
                }
                .navigationBarHidden(true)}
        }.JMAlert(showModal: $locationManager.permissionIsNotOk, for: [.location], autoCheckAuthorization: false)
    }
    
    
}

struct ActivityListView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListView(activities: activities.list)
    }
}
