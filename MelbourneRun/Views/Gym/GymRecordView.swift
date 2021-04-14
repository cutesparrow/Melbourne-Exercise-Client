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
import ActivityIndicatorView
import AlertToast

struct GymRecordView: View {
    @EnvironmentObject var userData:UserData
    @State var bottomSheetIsShow:Bool = false
    @Binding var gymList:GymList
    @State var networkError:Bool = false
    @State private var showLoadingIndicator = false
    @State var roadSituation:RecentlyRoadSituation = RecentlyRoadSituation(list: [])
    var gym:Gym
    var gymIndex: Int {
        gymList.list.firstIndex(where: { $0.id == gym.id })!
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
        let source = MKMapItem(placemark: MKPlacemark(coordinate: checkUserLocation(lat: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, long: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) ? CLLocationCoordinate2D(latitude: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) : CLLocationCoordinate2D(latitude: -37.810489070978186, longitude: 144.96290632581503)))
        source.name = "Source"
        
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: gym.lat, longitude: gym.long)))
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
        ZStack{
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
            ZStack{
                if showLoadingIndicator{
                    VisualEffectView(effect: UIBlurEffect(style: .light))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .frame(width: 60, height: 60, alignment: .center)}
                ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .default)
                .frame(width: 40.0, height: 40.0)
                    .foregroundColor(AppColor.shared.gymColor)}
        }
        .toast(isPresenting: $networkError, duration: 1.2, tapToDismiss: true, alert: { AlertToast(type: .error(.red), title: "Network Error", subTitle: "")
        }, completion: {_ in
            self.networkError = false
        })
        .sheet(isPresented: $bottomSheetIsShow, content: {
            PlanView(roadSituation: $roadSituation, isShown: $bottomSheetIsShow).environmentObject(userData)
        })
//        .bottomSheet(isPresented: $bottomSheetIsShow, height: 600, content: {PlanView(roadSituation: $roadSituation, isShown: $bottomSheetIsShow).environmentObject(userData)
//        })
        .ignoresSafeArea()
        .onAppear(perform: {
            loadRoadSituation(location: checkUserLocation(lat: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, long: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) ? CLLocationCoordinate2D(latitude: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) : CLLocationCoordinate2D(latitude: -37.810489070978186, longitude: 144.96290632581503), gymId: gym.id)
            userData.selectedGym = gym
        })
    }
}

//struct GymRecordView_Previews: PreviewProvider {
//    static var data:UserData = UserData()
//    static var previews: some View {
//        GymRecordView(gymList: .constant(GymList(list: [])), gym: data.gymList.list[0])
//            .environmentObject(data)
//    }
//}
