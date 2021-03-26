//
//  GymHomeView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 23/3/21.
//

import SwiftUI
import MapKit


struct GymHomeView: View {
    @EnvironmentObject var userData:UserData
    
    var body: some View {
        Group{
        GymListView()
            .padding(.bottom,90)
            .environmentObject(userData)
            .onAppear(perform: {
                self.userData.getGymList(location: CLLocationCoordinate2D(latitude: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503))
            })
            .listStyle(PlainListStyle())
            .ignoresSafeArea(.all, edges: .all)
            .frame(width: UIScreen.main.bounds.width)
        }.navigationTitle("Gyms")
        .navigationBarTitleDisplayMode(.automatic)
    }
}

struct GymHomeView_Previews: PreviewProvider {
    static var previews: some View {
        GymHomeView().environmentObject(UserData())
    }
}
