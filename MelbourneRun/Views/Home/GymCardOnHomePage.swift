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
import AlertToast
import Mapbox
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections
import Polyline

struct GymCardOnHomePage: View {
    @ObservedObject var gym:GymCore
    @Binding var showThisCard:Bool
    @State var loading:Bool = false
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var userData:UserData
    @State var roadSituation:RecentlyRoadSituation = RecentlyRoadSituation(list: [])
    @State var bottomSheetIsShow:Bool = false
    @State var directionsRoute:Route?
    @State var routeOptions: RouteOptions?
    @State var showDirection:Bool = false
    @State var showSheet:Bool = false
    @State var showPlan:Bool = false
    func fetchDirection() -> Void{
        self.loading = true
        let waypoints = [
            Waypoint(coordinate: checkUserLocation(lat: LocationFetcher.share.lastKnownLocation?.latitude ?? -37.810489070978186, long: LocationFetcher.share.lastKnownLocation?.longitude ?? 144.96290632581503) ? CLLocationCoordinate2D(latitude: LocationFetcher.share.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: LocationFetcher.share.lastKnownLocation?.longitude ?? 144.96290632581503) : CLLocationCoordinate2D(latitude: -37.810489070978186, longitude: 144.96290632581503), name: "source"),
            Waypoint(coordinate: CLLocationCoordinate2D(latitude: gym.lat, longitude: gym.long), name: gym.name),
        ]
        let options = RouteOptions(waypoints: waypoints)
        options.includesSteps = true
        options.includesVisualInstructions = true
        self.routeOptions = options
        let _ = Directions.shared.calculate(options) { (session, result) in
            switch result {
            case .failure(let error):
                print("Error calculating directions: \(error)")
                self.loading = false
            case .success(let response):
                guard let route = response.routes?.first else {
                    return
                }
                self.directionsRoute = route
                
                DispatchQueue.main.async{self.showDirection = true}
                self.showSheet = true
                print(route.description)
                self.loading = false
            }
        }
        
    }

    func loadRoadSituation(location:CLLocationCoordinate2D,gymId:Int){
        let completion: (Result<RecentlyRoadSituation,Error>) -> Void = { result in
            switch result {
            case let .success(list):
                DispatchQueue.main.async{
                    self.roadSituation = list
                    debugPrint(list)
                    
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                    DispatchQueue.main.async{self.showPlan = true}
                    self.loading = false
                    self.showSheet = true
                }
                
//                self.showLoadingIndicator = false
            case let .failure(error): print(error)
                self.loading = false
//                self.showLoadingIndicator = false
//                self.networkError = true
            }
        }
//        self.showLoadingIndicator = true
        self.loading = true
        _ = NetworkAPI.loadRoadSituation(location: location,gymId: gymId, completion: completion)
    }
    
    func calculateTime(time1:String,time2:String) -> Int {
        let time1 = time1.split(separator: ":")
        let time2 = time2.split(separator: ":")
        let distance =  (Int(time2[0])! - Int(time1[0])!) * 60
        let distance2 = Int(time2[1])! - Int(time1[1])!
        return distance + distance2
    }
    
    func getStatus(gym:GymCore) -> (String,Color,String,String){
        let calendar = Calendar.current
        let current = Date()
        let formater = DateFormatter()
        formater.dateFormat = "HH:mm"
        let currentTime = formater.string(from: current)
        
        if let weekday = calendar.dateComponents([.weekday], from: Date()).weekday {
            switch weekday {
            case 1:
                let start = gym.gymTime?.sunday_start
                let close = gym.gymTime?.sunday_close
                let toStart = calculateTime(time1: currentTime, time2: start!)
                let toEnd = calculateTime(time1: currentTime, time2: close! == "0:00" ? "24:00" : close!)
                if toStart < 0 && toEnd > 0 {
                    if toEnd < 30{
                        return ("Closing soon",Color(hex:0xe15d03),start!,close!)
                    } else {
                        return ("Open",Color(hex:0x339933),start!,close!)
                    }
                } else if toStart > 0 {
                    if toStart < 30{
                        return ("Opening soon",Color(hex:0xe15d03),start!,close!)
                    } else {
                        return ("Closed",Color(hex:0xcf0000),start!,close!)
                    }
                    
                } else if toEnd < 0 {
                    return ("Closed",Color(hex:0xcf0000),start!,close!)
                }
                
                
            case 2:
                let start = gym.gymTime?.monday_start
                let close = gym.gymTime?.monday_close
                let toStart = calculateTime(time1: currentTime, time2: start!)
                let toEnd = calculateTime(time1: currentTime, time2: close! == "0:00" ? "24:00" : close!)
                if toStart < 0 && toEnd > 0 {
                    if toEnd < 30{
                        return ("Closing soon",Color(hex:0xe15d03),start!,close!)
                    } else {
                        return ("Open",Color(hex:0x339933),start!,close!)
                    }
                } else if toStart > 0 {
                    if toStart < 30{
                        return ("Opening soon",Color(hex:0xe15d03),start!,close!)
                    } else {
                        return ("Closed",Color(hex:0xcf0000),start!,close!)
                    }
                    
                } else if toEnd < 0 {
                    return ("Closed",Color(hex:0xcf0000),start!,close!)
                }
            case 3:
                let start = gym.gymTime?.tuesday_start
                let close = gym.gymTime?.tuesday_close
                let toStart = calculateTime(time1: currentTime, time2: start!)
                let toEnd = calculateTime(time1: currentTime, time2: close! == "0:00" ? "24:00" : close!)
                if toStart < 0 && toEnd > 0 {
                    if toEnd < 30{
                        return ("Closing soon",Color(hex:0xe15d03),start!,close!)
                    } else {
                        return ("Open",Color(hex:0x339933),start!,close!)
                    }
                } else if toStart > 0 {
                    if toStart < 30{
                        return ("Opening soon",Color(hex:0xe15d03),start!,close!)
                    } else {
                        return ("Closed",Color(hex:0xcf0000),start!,close!)
                    }
                    
                } else if toEnd < 0 {
                    return ("Closed",Color(hex:0xcf0000),start!,close!)
                }
            case 4:
                let start = gym.gymTime?.wednesday_start
                let close = gym.gymTime?.wednesday_close
                let toStart = calculateTime(time1: currentTime, time2: start!)
                let toEnd = calculateTime(time1: currentTime, time2: close! == "0:00" ? "24:00" : close!)
                if toStart < 0 && toEnd > 0 {
                    if toEnd < 30{
                        return ("Closing soon",Color(hex:0xe15d03),start!,close!)
                    } else {
                        return ("Open",Color(hex:0x339933),start!,close!)
                    }
                } else if toStart > 0 {
                    if toStart < 30{
                        return ("Opening soon",Color(hex:0xe15d03),start!,close!)
                    } else {
                        return ("Closed",Color(hex:0xcf0000),start!,close!)
                    }
                    
                } else if toEnd < 0 {
                    return ("Closed",Color(hex:0xcf0000),start!,close!)
                }
            case 5:
                let start = gym.gymTime?.thursday_start
                let close = gym.gymTime?.thursday_close
                let toStart = calculateTime(time1: currentTime, time2: start!)
                let toEnd = calculateTime(time1: currentTime, time2: close! == "0:00" ? "24:00" : close!)
                if toStart < 0 && toEnd > 0 {
                    if toEnd < 30{
                        return ("Closing soon",Color(hex:0xe15d03),start!,close!)
                    } else {
                        return ("Open",Color(hex:0x339933),start!,close!)
                    }
                } else if toStart > 0 {
                    if toStart < 30{
                        return ("Opening soon",Color(hex:0xe15d03),start!,close!)
                    } else {
                        return ("Closed",Color(hex:0xcf0000),start!,close!)
                    }
                    
                } else if toEnd < 0 {
                    return ("Closed",Color(hex:0xcf0000),start!,close!)
                }
            case 6:
                let start = gym.gymTime?.friday_start
                let close = gym.gymTime?.friday_close
                let toStart = calculateTime(time1: currentTime, time2: start!)
                let toEnd = calculateTime(time1: currentTime, time2: close! == "0:00" ? "24:00" : close!)
                if toStart < 0 && toEnd > 0 {
                    if toEnd < 30{
                        return ("Closing soon",Color(hex:0xe15d03),start!,close!)
                    } else {
                        return ("Open",Color(hex:0x339933),start!,close!)
                    }
                } else if toStart > 0 {
                    if toStart < 30{
                        return ("Opening soon",Color(hex:0xe15d03),start!,close!)
                    } else {
                        return ("Closed",Color(hex:0xcf0000),start!,close!)
                    }
                    
                } else if toEnd < 0 {
                    return ("Closed",Color(hex:0xcf0000),start!,close!)
                }
            case 7:
                let start = gym.gymTime?.saturday_start
                let close = gym.gymTime?.saturday_close
                let toStart = calculateTime(time1: currentTime, time2: start!)
                let toEnd = calculateTime(time1: currentTime, time2: close! == "0:00" ? "24:00" : close!)
                if toStart < 0 && toEnd > 0 {
                    if toEnd < 30{
                        return ("Closing soon",Color(hex:0xe15d03),start!,close!)
                    } else {
                        return ("Open",Color(hex:0x339933),start!,close!)
                    }
                } else if toStart > 0 {
                    if toStart < 30{
                        return ("Opening soon",Color(hex:0xe15d03),start!,close!)
                    } else {
                        return ("Closed",Color(hex:0xcf0000),start!,close!)
                    }
                    
                } else if toEnd < 0 {
                    return ("Closed",Color(hex:0xcf0000),start!,close!)
                }
            default:
                return ("",Color(.blue),"","")
            }
        }
        return ("",Color.blue,"","")
    }
    
    var body: some View {
        let gymStatus = getStatus(gym:gym)
        return
            VStack{
            Spacer()
                .frame(height:UIScreen.main.bounds.height/2 - 70)
            ZStack{
            VisualEffectView(effect: UIBlurEffect(style: .systemThickMaterial))
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
                        Text(" ??? Distance: \(gym.distance.description) km")
                            .font(.system(size: 14))
                            .foregroundColor(Color(.label))
                            .lineLimit(1)
                    }
                    Text(gym.address)
                        .font(.system(size: 14))
                        .foregroundColor(Color(.label))
                        .lineLimit(1)
                    HStack{
                        Text(gymStatus.0)
                            .font(.system(size: 14))
                            .foregroundColor(gymStatus.1)
                            .lineLimit(1)
                        Text(" ??? ")
                            .font(.system(size: 14))
                            .foregroundColor(Color(.label))
                            .lineLimit(1)
                        Text(gymStatus.2 == "0:00" && gymStatus.3 == "0:00" ? "24 hours" : "\(gymStatus.2) - \(gymStatus.3)")
                            .font(.system(size: 14))
                            .foregroundColor(Color(.label))
                            .lineLimit(1)
                    }
                }.padding(.leading,10)
                .padding(.vertical,10)
                HStack{
                    Button(action: {
                        DispatchQueue.main.async{
                            
                            fetchDirection()
                        }
                        
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
                            Text("Plan")
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
            .fullScreenCover(isPresented: $showSheet, content: {
                GymPlanOrNavigationSwitchView(showSheet: $showSheet, showDirection: $showDirection, directionsRoute: $directionsRoute, routeOptions: $routeOptions, gym: gym, showPlan: $showPlan, roadSituation: $roadSituation, start: gymStatus.2, close: gymStatus.3 == "0:00" ? "23:59" : gymStatus.3)
                    .environmentObject(userData)
            })
            .toast(isPresenting: $loading, alert: {AlertToast(displayMode: .alert, type: .loading, title: "loading")})
        }
        
    }
}


