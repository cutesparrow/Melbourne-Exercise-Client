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
    @StateObject var recommandedRoutes:RecommandedRouteViewModel = RecommandedRouteViewModel()
    @State var showSheet:Bool = false
    @State var isopenManue:Bool = false
    @State var showJoggingGuide:Bool = true
    @State var sheetKind:Int = 0
    @State var expandLaebl:Bool = false
//    @State var networkError:Bool = false
//    @State var showLoadingIndicator:Bool = false
//    @State var loadedPopularCards:Bool = false
//    @State var loadedCustomizedCards:Bool = false
    @State var popularCards:[CyclingCard] = []
    @State var customizedCards:[WalkingRouteCard] = []
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
                .padding(.trailing,-7.5)
            VStack(alignment: .leading, spacing: 2) {
                  Text("User Guide")
                     .foregroundColor(Color(.label))
                      .fontWeight(.bold)
                      .lineLimit(3)
                  Text("You can explore the map to see the real time pedestrian flow around the city. Have a try on the “Walk&Dog” or “cycling” options if you want to plan your route for a walk, walk a dog, or a bike ride.")
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
    
//    func loadCustomizedCardsData(location:CLLocationCoordinate2D,length:Double,type:String){
//        let completion: (Result<[WalkingRouteCard], Error>) -> Void = { result in
//            switch result {
//            case let .success(list):
//                if list.count != 0{
//                self.customizedCards = list
//                self.marks.loading = false
//                self.loadedPopularCards = true
//                self.showSheet.toggle()
//
//                self.isopenManue.toggle()
//            }
//                else{
//                    self.marks.loading = false
//                    self.loadedPopularCards = false
//                    self.networkError = true
//                }
//            case let .failure(error): print(error)
//                self.marks.loading = false
//                self.loadedPopularCards = false
//                self.networkError = true
//            }
//        }
//        self.marks.loading = true
//        _ = NetworkAPI.loadCustomizedCards(location: location, length: length,type:type, completion: completion)
//    }
  
    var body: some View {
        
        let textButtons = [AnyView(IconAndTextButton(loading:self.$recommandedRoutes.loading,networkError:self.$recommandedRoutes.error,selectedSheet: "cycle", mainswitch: $isopenManue, isshow: $showSheet, sheetKind: $sheetKind, customizedCards: $customizedCards, popularCards: $popularCards, loaded: self.$recommandedRoutes.successCycling, showDistanceInput: $showDistanceInput, type: $type, imageName: MockData.iconAndTextImageNames[0], buttonText: MockData.iconAndTextTitles[0]).environmentObject(userData)
        ),AnyView(IconAndTextButton(loading:self.$recommandedRoutes.loading,networkError:self.$recommandedRoutes.error,selectedSheet: "walk", mainswitch: $isopenManue, isshow: $showSheet, sheetKind: $sheetKind, customizedCards: $customizedCards, popularCards: $popularCards, loaded: self.$recommandedRoutes.successWalking, showDistanceInput: $showDistanceInput, type: $type, imageName: MockData.iconAndTextImageNames[1], buttonText: MockData.iconAndTextTitles[1]).environmentObject(userData))]
        
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
                if !recommandedRoutes.showSheet{Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $trackingMode, annotationItems: recommandedRoutes.showSheet ? result : result, annotationContent: { mark in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: mark.lat, longitude: mark.long)) {
                    SensorMapAnnotationView(animation: $showSheet, id: Int(mark.uid), color: mark.risk == "high" ? .red : mark.risk == "medium" ? .orange : mark.risk == "low" ? .yellow : .green, speed:mark.risk == "high" ? 1 : mark.risk == "medium" ? 0.7 : mark.risk == "low" ? 0.5 : 0.3)
                }})
                .ignoresSafeArea()}
                else {
                    Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $trackingMode)
                        .ignoresSafeArea()
                }
            ZStack {
                HStack{RiskLabelView(expand: $expandLaebl)
                    .padding()
                Spacer()}
                        HStack{
                            Button(action: {
                                withAnimation{expandLaebl = false}
                                DispatchQueue.main.asyncAfter(deadline:.now()+0.4){self.marks.reGetSensorSituation(context: context)}
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
                                    self.recommandedRoutes.loadRecommandedRoutes(location: checkUserLocation(lat: LocationFetcher.share.lastKnownLocation?.latitude ?? -37.810489070978186, long: LocationFetcher.share.lastKnownLocation?.longitude ?? 144.96290632581503) ? CLLocationCoordinate2D(latitude: LocationFetcher.share.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: LocationFetcher.share.lastKnownLocation?.longitude ?? 144.96290632581503) : CLLocationCoordinate2D(latitude: -37.810489070978186, longitude: 144.96290632581503), length: choosedRouteLength, type: type,context: context)
//                                    self.loadCustomizedCardsData(location: checkUserLocation(lat: LocationFetcher.share.lastKnownLocation?.latitude ?? -37.810489070978186, long: LocationFetcher.share.lastKnownLocation?.longitude ?? 144.96290632581503) ? CLLocationCoordinate2D(latitude: LocationFetcher.share.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: LocationFetcher.share.lastKnownLocation?.longitude ?? 144.96290632581503) : CLLocationCoordinate2D(latitude: -37.810489070978186, longitude: 144.96290632581503), length: choosedRouteLength, type: type)
                                } label: {
                                    Text("OK")
                                }

                            }
                    }
                        
                    }.frame(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/2.5, alignment: .center)
                }
                
        }
            
            .onChange(of: isopenManue, perform: { value in
                
                    withAnimation{expandLaebl = false}
                
            })
            .onTapGesture {
                withAnimation{expandLaebl = false}
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .toast(isPresenting: $marks.error, duration: 1.2, tapToDismiss: true, alert: { AlertToast(type: .error(.red), title: "Network Error", subTitle: "")
        }, completion: {_ in
            marks.error = false
        })
            .toast(isPresenting: $recommandedRoutes.error, duration: 1.2, tapToDismiss: true, alert: { AlertToast(type: .error(.red), title: "Network Error", subTitle: "")
        }, completion: {_ in
            recommandedRoutes.error = false
        })
            .toast(isPresenting: $recommandedRoutes.loading, alert: {
                AlertToast(displayMode: .alert, type: .loading, title: "loading")
            })
            .toast(isPresenting: $marks.loading, alert: {
                AlertToast(displayMode: .alert, type: .loading, title: "loading")
            })
        .present(isPresented: $showJoggingGuide, type: .floater(), position: .top, animation:  Animation.spring(), autohideDuration: nil, closeOnTap: true, onTap: {
        }, closeOnTapOutside: true, view: {
            createBottomFloaterView()
        })
            .sheet(isPresented: self.$recommandedRoutes.showSheet, content: {
            if sheetKind == 1{
                CyclePathView(show:$recommandedRoutes.showSheet)
                    .environmentObject(userData)
                    .onDisappear {
                        self.recommandedRoutes.delete(context: context)
                    }
                    .environment(\.managedObjectContext, context)
                    
            } else if sheetKind == 2{
                WalkingRouteView(show:$recommandedRoutes.showSheet)
                    .environmentObject(userData)
                    .onDisappear {
                        self.recommandedRoutes.delete(context: context)
                    }
                    .environment(\.managedObjectContext, context)
            } else{
                
            }
        })
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
                if userData.joggingpageFirstAppear{
//                self.
                self.marks.reGetSensorSituation(context: context)
                userData.joggingpageFirstAppear = false
            }
                
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
                withAnimation {
                    isopenManue.toggle()
                }
            }
                
            
        })
       

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


