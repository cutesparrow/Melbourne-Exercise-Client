//
//  HikingHomeView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 23/3/21.
//

import SwiftUI
import MapKit

struct HikingHomeView: View {
    @EnvironmentObject var userData:UserData
    var body: some View {
        Text("Hello, World!")
            .navigationTitle("Parks")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(backgroundColor: UIColor(AppColor.shared.parkColor), tintColor: .white)
            .onAppear(perform: {
                self.userData.getGymList(location: CLLocationCoordinate2D(latitude: userData.locationFetcher.lastKnownLocation!.latitude, longitude: userData.locationFetcher.lastKnownLocation!.longitude))
            })
    }
}

struct HikingHomeView_Previews: PreviewProvider {
    static var previews: some View {
        HikingHomeView().environmentObject(UserData())
    }
}
