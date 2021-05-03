//
//  RoundedGymIconOnMapView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 2/5/21.
//

import SwiftUI
import Looping
import LoopingWebP
import SDWebImageSwiftUI
import MapKit
import URLImage


struct RoundedGymIconOnMapView: View {
    @ObservedObject var gym:GymCore
    @Binding var region:MKCoordinateRegion
    @Binding var selectedGymUid:Int
    @Binding var gotTap:Bool
    @FetchRequest(entity: GymCore.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GymCore.distance, ascending: true)]) var result: FetchedResults<GymCore>
    var animation: Animation {
        Animation.default
            .speed(1)
    }
//    @State private var isAnimated = false
    private func findIndexOfGym(gym:GymCore) -> Int?{
        var index:Int = 0
        for i in result{
            if gym.uid == i.uid{
                return index
            }
            index += 1
        }
        return nil
    }
//    var speed:Double = 0.2
    var body: some View {
        if !result.isEmpty{
//            WebImage(url: URL(string: NetworkManager.shared.urlBasePath + (gym.images?.sortedArray(using: [NSSortDescriptor(keyPath: \ImageCore.uid, ascending: true)]) as! [ImageCore])[0].name + ".jpg"))
//                .placeholder(content: {
//                    Color(.gray)
//                })
            Image("yarra-trail")
            .resizable()
            .scaledToFill()
            .frame(width: selectedGymUid == Int(gym.uid) ? 65 : 30, height: selectedGymUid == Int(gym.uid) ? 65 : 40, alignment: .center)
            .clipShape(Circle())
                .overlay(Circle().stroke(selectedGymUid == Int(gym.uid) ? Color(.green).opacity(0.5) : AppColor.shared.joggingColor.opacity(0.5),lineWidth: selectedGymUid == Int(gym.uid) ? 3 : 1.4))
//            .border(AppColor.shared.gymColor.opacity(selectedGym == gym ? 0.9 : 0.5), width: selectedGym == gym ? 5 : 3)
//            .scaleEffect(wave1 ? 1.1 : 1)
//            .opacity(wave1 ? 0.85 : 1)
//            .scaleEffect(isAnimated ? 0.8 : 1)
//            .animation(animation)
            .onTapGesture {
                withAnimation(animation){
//                    print(gym.uid)
                    self.selectedGymUid = Int(gym.uid)
                    region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: gym.lat-0.003, longitude: gym.long), span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015))
                    self.gotTap.toggle()
                }
            }
//                .onChange(of: selectedGymUid, perform: { value in
//                    region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: gym.lat-0.003, longitude: gym.long), span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015))
//                })
        }
    }
}

