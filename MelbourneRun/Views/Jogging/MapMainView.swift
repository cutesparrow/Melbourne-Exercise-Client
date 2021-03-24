//
//  MapMainView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 9/3/21.
//

import SwiftUI
import CoreLocation
import MapKit

struct MapMainView: View {
    @EnvironmentObject var userData:UserData
    @State private var bottomSheetShown = true
    
    var body: some View {
        
        GeometryReader { geometry in
            MapView(coordinates: userData.joggingPath)
            BottomView(
                isOpen: self.$bottomSheetShown,
                maxHeight: geometry.size.height * 0.45
            ) {
                BottomContentView()
                    .environmentObject(userData)
            }
        }.edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            self.userData.getJoggingPath(location: CLLocationCoordinate2D(latitude: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503), ifreturn: "False")
        })
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarColor(backgroundColor: UIColor(Color(.tertiarySystemBackground).opacity(0.3)), tintColor: UIColor(Color.blue))
    }
}

struct MapMainView_Previews: PreviewProvider {
    static let data = UserData()
    static var previews: some View {
        MapMainView()
            .environmentObject(data)
    }
}
