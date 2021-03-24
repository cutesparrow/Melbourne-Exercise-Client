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
        GymListView()
            .environmentObject(userData)
            .navigationTitle("Gyms")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(backgroundColor: UIColor(AppColor.shared.gymColor), tintColor: .white)
            .onAppear(perform: {
                self.userData.getGymList(location: CLLocationCoordinate2D(latitude: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503))
            })
    }
}

struct GymHomeView_Previews: PreviewProvider {
    static var previews: some View {
        GymHomeView().environmentObject(UserData())
    }
}
