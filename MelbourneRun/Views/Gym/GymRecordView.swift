//
//  GymRecordView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 18/3/21.
//

import SwiftUI
import MapKit
import CoreLocation
import BottomSheet

struct GymRecordView: View {
    @EnvironmentObject var userData:UserData
    @State var bottomSheetIsShow:Bool = false
    var gym:Gym
    var gymIndex: Int {
        userData.gymList.list.firstIndex(where: { $0.id == gym.id })!
    }
    var locationManager = CLLocationManager()
    
    func setupManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    func LocationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])->CLLocationCoordinate2D {
        manager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
    }
    
    func openMapApp()->Void{
        setupManager()
        let userLocation = LocationManager(locationManager, didUpdateLocations: [])
        let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)))
        source.name = "Source"
        
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: gym.lat, longitude: gym.long)))
        destination.name = "Destination"
        
        MKMapItem.openMaps(
            with: [source, destination],
            launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        )
    }
    
    var body: some View {
        ScrollView(content: {
            VStack{
                LocationMapView(lat: gym.lat, long: gym.long)
                    .ignoresSafeArea(edges: .top)
                    .frame(height: UIScreen.main.bounds.width/1.2)
                HStack{
                    VStack(alignment:.leading){
                        Spacer()
                    Text(gym.name)
                        .lineLimit(1)
                        .font(.title3)
                    
                    HStack{Text("Limitation:")
                                .font(.title3)
                                .bold()
                                
                            Image(systemName: "\(gym.limitation).circle")
                                .font(.system(size: 22, weight: .regular))
                    }.foregroundColor(Color(.label).opacity(0.65))
                    }
                    Spacer()
                    CircleImagePlusView(name: gym.Images[0])
                }
                .padding(.leading)
                .padding(.trailing)
                .offset(y: -UIScreen.main.bounds.width/6)
                
                VStack(alignment:.leading) {
                    HStack(alignment: .top){
                        Text(gym.address)
                            .font(.subheadline)
                        Spacer()
                        Text("\(gym.distance.description)KM")
                            .font(.subheadline)
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    Divider()
                    HStack{
                        Spacer()
                        Button(action: openMapApp, label: {
                            DetailPageButton(icon: "arrow.up.circle", color: .blue, text: "GO")
                        })
                        Spacer()
                        Divider()
                            .frame(width: 5, height: 30, alignment: .center)
                        Spacer()
                        PlanButtonView(bottomSheetIsShow:$bottomSheetIsShow)
                        Spacer()
                    }.padding(.top,5)
                    .padding(.bottom,-5)
                }
                .offset(y: -UIScreen.main.bounds.width/6.5)
                ImageScrollView(Images: getScrollImageList(images: gym.Images))
                    .offset(y: -UIScreen.main.bounds.width/6)
            }.background(Color.clear)
        })
        .bottomSheet(isPresented: $bottomSheetIsShow, height: 600, content: {PlanView(isShown: $bottomSheetIsShow).environmentObject(userData)
        })
        .ignoresSafeArea()
        .onAppear(perform: {
            userData.getRoadSituation(location: CLLocationCoordinate2D(latitude: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503), gymId: gym.id)
        })
    }
}

struct GymRecordView_Previews: PreviewProvider {
    static var data:UserData = UserData()
    static var previews: some View {
        GymRecordView(gym: data.gymList.list[0])
            .environmentObject(data)
    }
}
