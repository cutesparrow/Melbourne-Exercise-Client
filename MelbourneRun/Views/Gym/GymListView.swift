//
//  GymListView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 18/3/21.
//

import SwiftUI
import MapKit

import SwiftUIRefresh



struct GymListView: View {
    @EnvironmentObject var userData:UserData
    @State private var isShowing = false
    var body: some View {
        List(userData.gymList.list) { gym in
            NavigationLink(destination: GymRecordView(gym: gym)) {
                GymCellView(gym: gym)
                    .padding(.top,10)
                    .padding(.bottom,10)
                    .shadow(radius: 10 )
            }
            
        }.pullToRefresh(isShowing: $isShowing) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.userData.reloadGymList(location: CLLocationCoordinate2D(latitude: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503))
                self.isShowing = false
            }
        }.onChange(of: self.isShowing) { value in
        }
    }
    
    
}

struct GymListView_Previews: PreviewProvider {
    static let data = UserData()
    static var previews: some View {
        GymListView()
            .environmentObject(data)
    }
}

