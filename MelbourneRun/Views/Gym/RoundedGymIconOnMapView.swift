//
//  RoundedGymIconOnMapView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 2/5/21.
//

import SwiftUI
import SDWebImageSwiftUI
import MapKit
import URLImage


struct RoundedGymIconOnMapView: View {
    var name:String

    
    var body: some View {
            Image(name)
            .resizable()
            .scaledToFill()
                .frame(width: 30, height: 30, alignment: .center)

//            .border(AppColor.shared.gymColor.opacity(selectedGym == gym ? 0.9 : 0.5), width: selectedGym == gym ? 5 : 3)
//            .scaleEffect(wave1 ? 1.1 : 1)
//            .opacity(wave1 ? 0.85 : 1)
//            .scaleEffect(isAnimated ? 0.8 : 1)
//            .animation(animation)
                
        
//            .onTapGesture {
//                withAnimation{
////                    print(gym.uid)
//                    self.selectedGymUid = Int(gym.uid)
//                    region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: gym.lat-0.003, longitude: gym.long), span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015))
//                    self.gotTap.toggle()
//                }
//            }
//                .onChange(of: selectedGymUid, perform: { value in
//                    region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: gym.lat-0.003, longitude: gym.long), span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015))
//                })
        
    }
}

