//
//  JoggingHomeView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 25/3/21.
//

import SwiftUI
import MapKit
import FloatingButton
import BottomSheet
import SSToastMessage


struct JoggingHomeView: View {
    @EnvironmentObject var userData:UserData
    
    @State var showSheet:Bool = false
    @State var isopenManue:Bool = false
    @State var sheetKind:Int = 0
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -37.81145542089078, longitude: 144.96473765203163), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
    @State private var trackingMode = MapUserTrackingMode.follow
    func createBottomFloaterView() -> some View {
          ZStack{
            VisualEffectView(effect: UIBlurEffect(style: .light))
                .frame(width: 350, height: 160)
                .cornerRadius(20.0)
            HStack(spacing: 15) {
            Image("logo")
                  .resizable()
                  .aspectRatio(contentMode: ContentMode.fill)
                  .frame(width: 60, height: 60)
            VStack(alignment: .leading, spacing: 2) {
                  Text("User Guide")
                    .foregroundColor(Color(.label))
                      .fontWeight(.bold)
                      .lineLimit(3)

                  Text("All pedestrian sensors' data are shown on the map. You can  plan your own jogging path or choose a popular path by clicking the plus symbol. We will recommend the lowest risk jogging path for you!")
                      .font(.system(size: 14))
                      .foregroundColor(Color(.label))
              }
          }
          .padding(15)
          }
      }
    var body: some View {
        
        
        let textButtons = [AnyView(IconAndTextButton(selectedSheet:"popular" ,mainswitch: $isopenManue, isshow: $showSheet, sheetKind: $sheetKind, imageName: MockData.iconAndTextImageNames[0], buttonText: MockData.iconAndTextTitles[0]).environmentObject(userData)
        ),AnyView(IconAndTextButton(selectedSheet:"customize",mainswitch: $isopenManue, isshow: $showSheet, sheetKind: $sheetKind, imageName: MockData.iconAndTextImageNames[1], buttonText: MockData.iconAndTextTitles[1]).environmentObject(userData))]

        let mainButton1 = AnyView(MainButton(imageName: "plus", color:AppColor.shared.joggingColor, width: 60))
        

        let menu1 = FloatingButton(mainButtonView: mainButton1, buttons: textButtons,isOpen: $isopenManue)
            .straight()
                       .direction(.top)
                       .alignment(.right)
                       .spacing(10)
                       .initialOpacity(0)
        return ZStack{
//            Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $trackingMode, annotationItems: userData.marks, annotationContent: { (mark) -> MapMarker in
//                MapMarker(coordinate: CLLocationCoordinate2D(latitude: mark.coordinate.latitude, longitude: mark.coordinate.longitude), tint: mark.risk == "high" ? .red : mark.risk == "medium" ? .orange : mark.risk == "low" ? .yellow : .green)
//            })
            Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $trackingMode, annotationItems: userData.marks, annotationContent: { mark in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: mark.lat, longitude: mark.long)) {
                    SensorMapAnnotationView(id: mark.id, color: mark.risk == "high" ? .red : mark.risk == "medium" ? .orange : mark.risk == "low" ? .yellow : .green, speed:mark.risk == "high" ? 1 : mark.risk == "medium" ? 0.7 : mark.risk == "low" ? 0.5 : 0.3)
                }})
                .ignoresSafeArea()
            HStack {
                RiskLabelView()
                    .padding()
                Spacer().layoutPriority(10)
                        menu1.padding(20)
                            .offset(y:UIScreen.main.bounds.height/3.2)
                    }
                
//            FloatingButton(mainButtonView: AnyView(MainButtonJoggingView(imageName: "plus", colorHex: 0xeb3b5a)), buttons: buttons)
//                .offset(x: UIScreen.main.bounds.width/2.5, y: UIScreen.main.bounds.width/1.5)
        }
        .present(isPresented: $userData.showJoggingGuide, type: .floater(), position: .top, animation:  Animation.spring(), autohideDuration: nil, closeOnTap: true, onTap: {
        }, closeOnTapOutside: true, view: {
            createBottomFloaterView()
        })
        .sheet(isPresented: $showSheet, content: {
            if sheetKind == 1{
                PopularPathView().environmentObject(userData)
            } else{
                CustomizePathView().environmentObject(userData)
            }
        })
        .onAppear(perform: {
            self.userData.getSensorSituation()
            self.userData.loadCustomizedCardsData(location: checkUserLocation(lat: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, long: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) ? CLLocationCoordinate2D(latitude: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) : CLLocationCoordinate2D(latitude: -37.810489070978186, longitude: 144.96290632581503))
        })
       
//        .fullScreenCover(isPresented: $showPopular, content: {
//
//                Text("popular")
//                    .onTapGesture {
//                        self.showPopular.toggle()
//                    }
//                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//
//        })
    }
}

struct JoggingHomeView_Previews: PreviewProvider {
    static var previews: some View {
        JoggingHomeView()
            .environmentObject(UserData())
    }
}

struct StartMapView: UIViewRepresentable {
    
    var locationManager = CLLocationManager()
    func setupManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        setupManager()
        let mapView = MKMapView(frame: UIScreen.main.bounds)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
}


