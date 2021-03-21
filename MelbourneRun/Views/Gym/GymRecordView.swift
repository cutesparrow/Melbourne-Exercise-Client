//
//  GymRecordView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 18/3/21.
//

import SwiftUI
import MapKit
import CoreLocation

struct GymRecordView: View {
    @EnvironmentObject var userData:UserData
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
                        .font(.body)
                        
                    
                    HStack{
                            Text("Limit:")
                                .font(.title3)
                                .bold()
                                .italic()
                            Image(systemName: "\(gym.limitation).circle")
                                .font(.system(size: 22, weight: .regular))
                        }.foregroundColor(Color.black.opacity(0.65))
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
                            DirectButtonView(color:Color.blue,text:"GO NOW")
                        })
                        Spacer()
                        Divider()
                            .frame(width: 5, height: 30, alignment: .center)
                        Spacer()
                        Button(action: openMapApp, label: {
                            DirectButtonView(color:Color.yellow,text:"PLAN")
                        })
                        Spacer()
                    }.padding(.top,15)
                }
                .offset(y: -UIScreen.main.bounds.width/6.5)
                
                ImageScrollView(Images: getScrollImageList(images: gym.Images))
                    .offset(y: -UIScreen.main.bounds.width/6)
                
            }.background(AppColor.shared.backgroundColor)
        }).ignoresSafeArea()
        
        
        
    }
}

struct GymRecordView_Previews: PreviewProvider {
    static var data:UserData = UserData()
    static var previews: some View {
        GymRecordView(gym: data.gymList.list[0])
            .environmentObject(data)
    }
}
