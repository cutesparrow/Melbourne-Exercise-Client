//
//  GymListView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 18/3/21.
//

import SwiftUI
import MapKit

struct GymListView: View {
    @EnvironmentObject var userData:UserData
    var body: some View {
        List(userData.gymList.list) { gym in
            NavigationLink(destination: GymRecordView(gym: gym)) {
                GymCellView(gym: gym)
                    .padding(.top,10)
                    .padding(.bottom,10)
                    .shadow(radius: 10 )
                
            }
            
        }
        .navigationTitle("Gyms")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarColor(backgroundColor: UIColor(AppColor.shared.gymColor), tintColor: .white)
        .onAppear(perform: {
            self.userData.getGymList(location: CLLocationCoordinate2D(latitude: -37.811822947, longitude: 144.963963))
        })
        
        
    }
    
struct GymListView_Previews: PreviewProvider {
        static let data = UserData()
        static var previews: some View {
            GymListView()
                .environmentObject(data)
        }
    }
}
