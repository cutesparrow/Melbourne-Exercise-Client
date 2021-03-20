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
        manager.location!.coordinate
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
                CircleImagePlusView(name: gym.Images[0])
                    .offset(x:UIScreen.main.bounds.width/4, y: -UIScreen.main.bounds.width/6)
                    
                VStack(alignment:.leading) {
                    Text(gym.name)
                        .font(.title)
                        .bold()
                        .frame(width: 200, height: 100)
                    HStack{
                        HStack{
                            HStack{
                                Button(action: openMapApp, label: {
                                    DirectButtonView(color:Color.blue,text:"GO")
                                })
                                Divider()
                                    .frame(width: 30, height: 30, alignment: .center)
                                Button(action: {self.userData.gymList.list[gymIndex].star.toggle()}, label: {
                                    Image(systemName: "star")
                                        .font(.system(size: 30))
                                        .padding(5)
                                        .background(self.userData.gymList.list[gymIndex].star ? Color.yellow:.white)
                                        .cornerRadius(40)
                                        .foregroundColor(self.userData.gymList.list[gymIndex].star ? .white:Color.yellow) //changed
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 40)
                                                .stroke(Color.yellow, lineWidth: 3)
                                        )
                                })
                            }
                            Spacer()
                            HStack{
                                Text("Limit:")
                                    .font(.title3)
                                    .bold()
                                    .italic()
                                Image(systemName: "\(gym.limitation).circle")
                                    .font(.system(size: 22, weight: .regular))
                            }.foregroundColor(Color.black.opacity(0.65))
                        }.padding(.leading).padding(.trailing)
                    }
                    Divider()
                    HStack(alignment: .top){
                        Text(gym.address)
                            .frame(width: UIScreen.main.bounds.width/1.4, alignment: .center)
                            .font(.subheadline)
                        Spacer()
                        Text("\(gym.distance.description)KM")
                            .font(.subheadline)
                    }.padding(.leading).padding(.trailing)
                }.offset(y:-155)
                
                ImageScrollView(Images: getScrollImageList(images: gym.Images))
                    .offset(y:-175)
                
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
