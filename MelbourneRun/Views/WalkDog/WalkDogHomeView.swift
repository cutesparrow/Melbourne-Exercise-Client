//
//  WalkDogHomeView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 23/3/21.
//

import SwiftUI
import MapKit

struct WalkDogHomeView: View {
    @EnvironmentObject var userData:UserData
    var body: some View {
        Text("Hello, World!")
            .navigationTitle("Dog Playground")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(backgroundColor: UIColor(AppColor.shared.playgroundColor), tintColor: .white)
            .onAppear(perform: {
                self.userData.getGymList(location: CLLocationCoordinate2D(latitude: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503))
            })
    }
}

struct WalkDogHomeView_Previews: PreviewProvider {
    static var previews: some View {
        WalkDogHomeView()
            .environmentObject(UserData())
            
    }
}
