//
//  GymCardOnHomePage.swift
//  MelbExercise
//
//  Created by gaoyu shi on 4/5/21.
//

//
//  GymCard.swift
//  MelbExercise
//
//  Created by gaoyu shi on 2/5/21.
//

import SwiftUI
import SDWebImageSwiftUI
import MapKit
import CoreLocation

struct GymCardOnHomePage: View {
    @ObservedObject var gym:GymCore
    @Binding var showThisCard:Bool
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var userData:UserData
    @State var roadSituation:RecentlyRoadSituation = RecentlyRoadSituation(list: [])
    @State var bottomSheetIsShow:Bool = false

    func loadRoadSituation(location:CLLocationCoordinate2D,gymId:Int){
        let completion: (Result<RecentlyRoadSituation,Error>) -> Void = { result in
            switch result {
            case let .success(list):
                DispatchQueue.main.async{
                    self.roadSituation = list
                    debugPrint(list)
                    self.bottomSheetIsShow.toggle()
                }
                
//                self.showLoadingIndicator = false
            case let .failure(error): print(error)
//                self.showLoadingIndicator = false
//                self.networkError = true
            }
        }
//        self.showLoadingIndicator = true
        _ = NetworkAPI.loadRoadSituation(location: location,gymId: gymId, completion: completion)
    }
    var body: some View {
        VStack{
            Spacer()
                .frame(height:UIScreen.main.bounds.height/2 - 70)
            ZStack{
            VisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
                .cornerRadius(20.0)
                .shadow(radius: 6)
            VStack(alignment:.leading,spacing:0){
                ZStack{
                    ScrollView(.horizontal){
                    HStack(spacing:3){ForEach((gym.images!.sortedArray(using: [NSSortDescriptor(keyPath: \ImageCore.uid, ascending: true)]) as! [ImageCore])){ image in
                    WebImage(url: URL(string: NetworkManager.shared.urlBasePath + image.name + ".jpg"))
                        .placeholder{
                            Color.gray
                        }
                        .resizable()
                        .scaledToFill()
                        .frame(width:230,height:110)
                        .clipped()
                }
              }
            }
                Button {
                        self.showThisCard.toggle()
                        
                } label:{
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.init(white: 0.9))
                            .font(.system(size: 32)).padding()
                }.offset(x: UIScreen.main.bounds.width/2 - 45, y: -30)
                

                }
                VStack(alignment:.leading){
                    Text(gym.name)
                        .font(.body)
                        .foregroundColor(Color(.label))
                        .lineLimit(1)
                        .padding(.bottom,5)
                    HStack(spacing:0){
                        Text("Limitation: \(gym.limitation.description)")
                        .font(.system(size: 14))
                        .foregroundColor(Color(.label))
                        .lineLimit(1)
                        Text(" ・ Distance: \(gym.distance.description) km")
                            .font(.system(size: 14))
                            .foregroundColor(Color(.label))
                            .lineLimit(1)
                    }
                    Text(gym.address)
                        .font(.system(size: 14))
                        .foregroundColor(Color(.label))
                        .lineLimit(1)
                    Text("Closing soon" + " ・ " + "15:00")
                        .font(.system(size: 14))
                        .foregroundColor(Color(.label))
                        .lineLimit(1)
                }.padding(.leading,10)
                .padding(.vertical,10)
                HStack{
                    Button(action: {
                        UserLocationManager.share.openMapApp(destination: CLLocationCoordinate2D(latitude: gym.lat, longitude: gym.long))
                    }, label: {
//                        DetailPageButton(icon: "arrow.up.circle", color: .blue, text: "GO")
                        HStack{
                            Image(systemName: "arrow.triangle.turn.up.right.diamond.fill")
                                .font(.system(size: 16,weight: .regular))
                                .foregroundColor(Color(.white))
                            Text("Directions")
                                .foregroundColor(Color(.white))
                        }.padding(.horizontal)
                        .padding(.vertical,5)
                    }).background(Capsule().fill(Color.blue))
                    Button(action: {
                        DispatchQueue.main.async{
                            loadRoadSituation(location: checkUserLocation(lat: LocationFetcher.share.lastKnownLocation?.latitude ?? -37.810489070978186, long: LocationFetcher.share.lastKnownLocation?.longitude ?? 144.96290632581503) ? CLLocationCoordinate2D(latitude: LocationFetcher.share.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: LocationFetcher.share.lastKnownLocation?.longitude ?? 144.96290632581503) : CLLocationCoordinate2D(latitude: -37.810489070978186, longitude: 144.96290632581503), gymId: Int(gym.uid))
                        }
                    }, label: {
//                        DetailPageButton(icon: "arrow.up.circle", color: .blue, text: "GO")
                        HStack{
                            Image(systemName: "text.book.closed.fill")
                                .font(.system(size: 16,weight: .regular))
                                .foregroundColor(Color(.white))
                            Text("Plans")
                                .foregroundColor(Color(.white))
                        }.padding(.horizontal)
                        .padding(.vertical,5)
                    }).background(Capsule().fill(Color.yellow))
                    Spacer(minLength: 0)
                    Button(action: {
                        self.showThisCard.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.4){
                            withAnimation{context.performAndWait{
                                gym.star.toggle()
                                try? context.save()
                        }}
                            
                        }
                    }) {
                        Image(systemName: gym.star ? "heart.fill" : "heart")
                            .foregroundColor(AppColor.shared.gymColor)
                            .font(.system(size: 30))
                    }
                }
                .padding(.horizontal,10)
                Spacer(minLength: 0)
            }.cornerRadius(20)
        }
        .frame(width:UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height/3-10, alignment: .center)
        .sheet(isPresented: $bottomSheetIsShow, content: {
            PlanView(name: gym.name,address:gym.address,roadSituation: $roadSituation, isShown: $bottomSheetIsShow).environmentObject(userData)
        })}
        
    }
}


