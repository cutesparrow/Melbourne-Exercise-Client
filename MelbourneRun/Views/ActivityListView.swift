//
//  ActivityListView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 14/3/21.
//

import SwiftUI

struct ActivityListView: View {
    @EnvironmentObject var userData:UserData
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
                            destination: Text("Hiking"),
                            label: {
                                ActivityView(activity:activities[0])
                            })
                        NavigationLink(
                            destination: GymListView()          .environmentObject(userData),
                            label: {
                                ActivityView(activity:activities[1])
                            })
                        NavigationLink(
                            destination: Text("WalkDog"),
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
        }
    }
}

struct ActivityListView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListView(activities: activities.list)
    }
}
