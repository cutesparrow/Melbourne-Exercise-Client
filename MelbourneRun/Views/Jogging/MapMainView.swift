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
            }
        }.edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            self.userData.getJoggingPath(location: CLLocationCoordinate2D(latitude: 1, longitude: 1))//should use user location later
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
