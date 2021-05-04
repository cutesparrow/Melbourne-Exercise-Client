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
import ActivityIndicatorView
import AlertToast

struct JoggingHomeView: View {
    @EnvironmentObject var userData:UserData
    @StateObject var marks:SensorMarkViewModel = SensorMarkViewModel()
    @State var showSheet:Bool = false
    @State var isopenManue:Bool = false
    @State var showJoggingGuide:Bool = true
    @State var sheetKind:Int = 0
    @State var networkError:Bool = false
    @State var showLoadingIndicator:Bool = false
    @State var loadedPopularCards:Bool = false
    @State var loadedCustomizedCards:Bool = false
    @State var popularCards:[PopularCard] = []
    @State var customizedCards:[CustomizedCard] = []
    @State var showDistanceInput:Bool = false
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -37.81145542089078, longitude: 144.96473765203163), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
    @State private var trackingMode = MapUserTrackingMode.follow
    @State private var choosedRouteLength:Double = 1
    @State var type:String = ""
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: SensorMarkCore.entity(), sortDescriptors: []) var result: FetchedResults<SensorMarkCore>
    
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
                .padding(.trailing,-10)
            VStack(alignment: .leading, spacing: 2) {
                  Text("User Guide")
                    .foregroundColor(Color(.label))
                      .fontWeight(.bold)
                      .lineLimit(3)
                  Text("All pedestrian sensors' data are shown on the map. You can  plan your own route and go for walking, walking dog or cycling by click plus button. Please have a look at the risk level before starting!")
                      .font(.system(size: 14))
                      .foregroundColor(Color(.label))
              }
          }
          .padding(15)
          }
      }
//    func getSensorSituation(){
//        let completion: (Result<[MarkerLocation],Error>) -> Void = { result in
//            switch result {
//            case let .success(marks): self.marks = marks
//                self.showLoadingIndicator = false
//            case let .failure(error): print(error)
//                self.showLoadingIndicator = false
//                self.networkError = true
//            }
//        }
//        self.showLoadingIndicator = true
//        _ = NetworkAPI.loadSensorSituation(completion: completion)
//    }
    
    func loadCustomizedCardsData(location:CLLocationCoordinate2D,length:Double,type:String){
        let completion: (Result<[CustomizedCard], Error>) -> Void = { result in
            switch result {
            case let .success(list):
                if list.count != 0{
                self.customizedCards = list
                self.marks.loading = false
                self.loadedPopularCards = true
                self.showSheet.toggle()
                    
                self.isopenManue.toggle()
            }
                else{
                    self.marks.loading = false
                    self.loadedPopularCards = false
                    self.networkError = true
                }
            case let .failure(error): print(error)
                self.marks.loading = false
                self.loadedPopularCards = false
                self.networkError = true
            }
        }
        self.marks.loading = true
        _ = NetworkAPI.loadCustomizedCards(location: location, length: length,type:type, completion: completion)
    }
  
    var body: some View {
        
        let textButtons = [AnyView(IconAndTextButton(loading:$showLoadingIndicator,networkError:$networkError,selectedSheet: "cycle", mainswitch: $isopenManue, isshow: $showSheet, sheetKind: $sheetKind, customizedCards: $customizedCards, popularCards: $popularCards, loaded: $loadedPopularCards, showDistanceInput: $showDistanceInput, type: $type, imageName: MockData.iconAndTextImageNames[0], buttonText: MockData.iconAndTextTitles[0]).environmentObject(userData)
        ),AnyView(IconAndTextButton(loading:$showLoadingIndicator,networkError:$networkError,selectedSheet: "walk", mainswitch: $isopenManue, isshow: $showSheet, sheetKind: $sheetKind, customizedCards: $customizedCards, popularCards: $popularCards, loaded: $loadedCustomizedCards, showDistanceInput: $showDistanceInput, type: $type, imageName: MockData.iconAndTextImageNames[1], buttonText: MockData.iconAndTextTitles[1]).environmentObject(userData))]
        
        let mainButton1 = AnyView(MainButton(imageName: "plus", color:AppColor.shared.joggingColor, width: 60))
        
        
        let menu1 = FloatingButton(mainButtonView: mainButton1, buttons: textButtons,isOpen: $isopenManue)
            .straight()
                       .direction(.top)
                       .alignment(.right)
                       .spacing(10)
                       .initialOpacity(0)
        return
            ZStack{
//            Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $trackingMode, annotationItems: userData.marks, annotationContent: { (mark) -> MapMarker in
//                MapMarker(coordinate: CLLocationCoordinate2D(latitude: mark.coordinate.latitude, longitude: mark.coordinate.longitude), tint: mark.risk == "high" ? .red : mark.risk == "medium" ? .orange : mark.risk == "low" ? .yellow : .green)
//            })
                Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $trackingMode, annotationItems: result, annotationContent: { mark in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: mark.lat, longitude: mark.long)) {
                    SensorMapAnnotationView(animation: $showSheet, id: Int(mark.uid), color: mark.risk == "high" ? .red : mark.risk == "medium" ? .orange : mark.risk == "low" ? .yellow : .green, speed:mark.risk == "high" ? 1 : mark.risk == "medium" ? 0.7 : mark.risk == "low" ? 0.5 : 0.3)
                }})
                .ignoresSafeArea()
            ZStack {
                HStack{RiskLabelView()
                    .padding()
                Spacer()}
                        HStack{
                            Button(action: {
                                self.marks.reGetSensorSituation(context: context)
                            }, label: {
                                ZStack{
                                    VisualEffectView(effect: UIBlurEffect(style: .light))
                                    .clipShape(Circle())
                                    .frame(width: 60, height: 60, alignment: .center)
                                    Image(systemName: "arrow.triangle.2.circlepath")
                                        .font(.system(size: 28))
                                }
                            })
                            Spacer().layoutPriority(10)
                            menu1
                        }
                        .padding()
                            .offset(y:UIScreen.main.bounds.height/3.2)
                    }
                
//            FloatingButton(mainButtonView: AnyView(MainButtonJoggingView(imageName: "plus", colorHex: 0xeb3b5a)), buttons: buttons)
//                .offset(x: UIScreen.main.bounds.width/2.5, y: UIScreen.main.bounds.width/1.5)
            ZStack{
                if marks.loading{
                    VisualEffectView(effect: UIBlurEffect(style: .light))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .frame(width: 60, height: 60, alignment: .center)}
                ActivityIndicatorView(isVisible: $marks.loading, type: .default)
                .frame(width: 40.0, height: 40.0)
                    .foregroundColor(AppColor.shared.joggingColor)
            }
                if showDistanceInput{
                    ZStack{
                        Color(.systemBackground)
                            .opacity(0.9)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                        VStack{
                        Text("Choose wanted route length")
                            .foregroundColor(Color(.label))
                        if type == "foot"{
                            Picker(selection: $choosedRouteLength, label: Text("length picker")) {
                            ForEach(Array(stride(from: 1.0, through: 5.0, by: 0.5)), id: \.self) { i in
                                Text("\(String(i)) km")
                                    .tag(i)
                                    .foregroundColor(Color(.label))
                                }
                            }
                        } else if type == "bike2"{
                            Picker(selection: $choosedRouteLength, label: Text("length picker")) {
                                ForEach(Array(stride(from: 1.0, through: 20.0, by: 1.0)), id: \.self) { i in
                                Text("\(String(i)) km")
                                    .tag(i)
                                    .foregroundColor(Color(.label))
                                }
                            }
                        }
                            HStack(spacing: UIScreen.main.bounds.width/7) {
                                Button {
                                    self.showDistanceInput.toggle()
                                } label: {
                                    Text("Cancel")
                                }
                                Button {
                                    self.showDistanceInput.toggle()
                                    self.loadCustomizedCardsData(location: checkUserLocation(lat: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, long: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) ? CLLocationCoordinate2D(latitude: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) : CLLocationCoordinate2D(latitude: -37.810489070978186, longitude: 144.96290632581503), length: choosedRouteLength, type: type)
                                } label: {
                                    Text("OK")
                                }

                            }
                    }
                        
                    }.frame(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/2.5, alignment: .center)
                }
                
        }
            .navigationTitle("")
            .navigationBarHidden(true)
            .toast(isPresenting: $marks.error, duration: 1.2, tapToDismiss: true, alert: { AlertToast(type: .error(.red), title: "Network Error", subTitle: "")
        }, completion: {_ in
            marks.error = false
        })
        .present(isPresented: $showJoggingGuide, type: .floater(), position: .top, animation:  Animation.spring(), autohideDuration: nil, closeOnTap: true, onTap: {
        }, closeOnTapOutside: true, view: {
            createBottomFloaterView()
        })
        .sheet(isPresented: $showSheet, content: {
            if sheetKind == 1{
                CyclePathView(customizedCards:customizedCards).environmentObject(userData)
            } else if sheetKind == 2{
                CustomizePathView(customizedCards: customizedCards).environmentObject(userData)
            } else{
                
            }
        })
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){if userData.joggingpageFirstAppear{
//                self.
                self.marks.reGetSensorSituation(context: context)
                userData.joggingpageFirstAppear = false
            }}
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


