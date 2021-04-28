//
//  GymDetailView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 28/4/21.
//

import SwiftUI
import MapKit
import CoreLocation
import BottomSheet
import ActivityIndicatorView
import AlertToast

struct GymDetailView: View {
    @EnvironmentObject var userData:UserData
    @State var bottomSheetIsShow:Bool = false
    
    @State var networkError:Bool = false
    @State private var showLoadingIndicator = false
    @State var roadSituation:RecentlyRoadSituation = RecentlyRoadSituation(list: [])
    
    var fetchedGym:Gym?
    
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
        let source = MKMapItem(placemark: MKPlacemark(coordinate: checkUserLocation(lat: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, long: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) ? CLLocationCoordinate2D(latitude: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) : CLLocationCoordinate2D(latitude: -37.810489070978186, longitude: 144.96290632581503)))
        source.name = "Source"
        
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: fetchedGym!.lat, longitude:fetchedGym!.long)))
        destination.name = "Destination"
        
        MKMapItem.openMaps(
            with: [source, destination],
            launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        )
    }
    func loadRoadSituation(location:CLLocationCoordinate2D,gymId:Int){
        let completion: (Result<RecentlyRoadSituation,Error>) -> Void = { result in
            switch result {
            case let .success(list): self.roadSituation = list
                self.showLoadingIndicator = false
            case let .failure(error): print(error)
                self.showLoadingIndicator = false
                self.networkError = true
            }
        }
        self.showLoadingIndicator = true
        _ = NetworkAPI.loadRoadSituation(location: location,gymId: gymId, completion: completion)
    }
    var body: some View {
            VStack{
                VStack{
                    
                    HStack{
                        
                        Button(action: {}) {
                            Image(systemName: "suit.heart")
                                .font(.system(size: 22))
                                .foregroundColor(AppColor.shared.gymColor)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            
                            // closing hero view...
                            
                            withAnimation(.spring()){
                                
//                                show.toggle()
                            }
                            
                        }) {
                            
                            Image(systemName: "xmark")
                                .font(.system(size: 22))
                                .foregroundColor(AppColor.shared.gymColor)
                        }
                    }
                    Spacer()
                        .frame(height:200)
//                    Image((fetchedGym?.Images[0])!)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(height: .infinity)
//                        .rotationEffect(.init(degrees: 12))
                        
                }
                .padding()
                .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                .background(Image((fetchedGym?.Images[0])!).resizable().scaledToFill())
                
//                ScrollView(UIScreen.main.bounds.height < 750 ? .vertical : .vertical, showsIndicators: false) {
                    
                    HStack{
                        
                        VStack(alignment: .leading, spacing: 10) {
                            
                            Text("Limitation: \(self.fetchedGym!.limitation)")
                                .foregroundColor(.gray)
                            
                            HStack{
                                Text(self.fetchedGym!.name)
                                .font(.system(size: 22))
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                Spacer()
                                Text("\(self.fetchedGym!.distance.description) KM")
                                    .font(.system(size: 22))
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .padding()
                    
                HStack{Text(self.fetchedGym!.address)
                        .foregroundColor(.black)
                        .padding(.top,20)
                        .padding(.horizontal)
                    Spacer()
                }
                    
                    HStack{
                        
                        VStack(alignment: .leading, spacing: 12) {
                            
//                            Text("Colors")
//                                .font(.title)
//                            ImageScrollView(Images: self.fetchedGym!.Images)
//                            HStack(spacing: 15){
//
//                                ForEach(1...6,id: \.self){i in
//
//                                    if true{
//
//                                        Button(action: {}) {
//                                            Circle()
//                                                .fill(Color("Color\(i)"))
//                                                .frame(width: 22, height: 22)
//                                        }
//                                    }
//                                }
//                            }
                        }
                        
                        Spacer(minLength: 0)
                    }
                    .padding(.horizontal)
                    .padding(.top,25)
                    
                    Spacer(minLength: 0)
                    
                    // Button...
                    
                    HStack{
                        Button(action: {}) {
                        
                        Text("GO")
                            .fontWeight(.bold)
                            .padding(.vertical)
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width/3)
                            .background(AppColor.shared.joggingColor)
                            .clipShape(Capsule())
                            .padding(.horizontal)
                    }
                        Button(action: {}) {
                            
                            Text("PLAN")
                                .fontWeight(.bold)
                                .padding(.vertical)
                                .foregroundColor(.white)
                                .frame(width: UIScreen.main.bounds.width/3)
                                .background(AppColor.shared.gymColor)
                                .clipShape(Capsule())
                                .padding(.horizontal)
                        }
                    }
                    .padding(.bottom,40)
                    .padding(.top)
                
                
            }
            .edgesIgnoringSafeArea(.all)
            .background(Color.white)
        
    }
}

struct GymDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GymDetailView(fetchedGym:Gym(id: 1, lat: 1, long: 1, name: "sdaflkjah", Images: ["yarra-trail"], limitation: 1, distance: 1, star: false, address: "12312 fsdklj sd, dfs , sdf, sdf", classType: ""))
    }
}
