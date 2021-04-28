//
//  PupolarJoggingPathHomeView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 19/4/21.
//

import SwiftUI
import SDWebImageSwiftUI
import MapKit
import SSToastMessage
import AlertToast
import ActivityIndicatorView
import SwiftUIRefresh


struct PupolarJoggingPathHomeView: View {
    @StateObject var popularRoutesModel:PopularRouteViewModel = PopularRouteViewModel()
    @State var selectedTab:Int = 0
    @EnvironmentObject var userData:UserData
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: PopularRouteCore.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \PopularRouteCore.uid, ascending: true)]) var result: FetchedResults<PopularRouteCore>
    @State var loading:Bool = false
    @Binding var showBottomBar:Bool
    @State var viewState = CGSize.zero
    @State var detailPage:Int = 1
    @State var isSelected = false
    @State var leftPercent: CGFloat = 0
    @State var loaded:Bool = false //change later
    @State var networkError:Bool = false
    @State var currentPage:Int = 0
    let openCardAnimation = Animation.timingCurve(0.7, -0.35, 0.2, 0.9, duration: 0.45)
    let itemHeight:CGFloat = 500
    let imageHeight:CGFloat = 400
    let SVWidth = UIScreen.main.bounds.width - 40
    @State var navigationBar:Bool = true
    @State var expandedItem:PopularRouteCore? = nil
    @State var expandedScreen_startPoint = CGRect(x: 0, y: 0, width: 100, height: 100)
    @State var expandedScreen_returnPoint = CGRect(x: 0, y: 0, width: 100, height: 100)
    @State var expandedScreen_shown = false
    @State var expandedScreen_willHide = false
    var locationManager = CLLocationManager()
    func setupManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    func LocationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])->CLLocationCoordinate2D {
        manager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
    }
    func openMapApp(lat:Double,long:Double)->Void{
        setupManager()
        let source = MKMapItem(placemark: MKPlacemark(coordinate: checkUserLocation(lat: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, long: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) ? CLLocationCoordinate2D(latitude: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) : CLLocationCoordinate2D(latitude: -37.810489070978186, longitude: 144.96290632581503)))
        source.name = "Source"
        
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long)))
        destination.name = "Destination"
        
        MKMapItem.openMaps(
            with: [source, destination],
            launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        )
    }
//    func loadPopularCardsData(location:CLLocationCoordinate2D){
//        let completion: (Result<[PopularJoggingRoute], Error>) -> Void = { result in
//            switch result {
//            case let .success(list): self.joggingRoutes = list
//                self.loading = false
//                self.loaded = true
//            case let .failure(error): print(error)
//                self.loading = false
//                self.loaded = false
//                self.networkError = true
//            }
//
//        }
//        self.loading = true
//        _ = NetworkAPI.loadPopularCards(location: location, completion: completion)
//    }
    var body: some View {
        
            ZStack{
             
        ZStack{
            Color(.systemBackground).edgesIgnoringSafeArea(.all)
            
            if !result.isEmpty{
            ScrollView{
                RefreshControl(coordinateSpace: .named("RefreshControl"), onRefresh: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        self.popularRoutesModel.reloadPopularCardsData(location: checkUserLocation(lat: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, long: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) ? CLLocationCoordinate2D(latitude: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) : CLLocationCoordinate2D(latitude: -37.810489070978186, longitude: 144.96290632581503), context: context)
                    }
                })
                HStack{
                    VStack(alignment: .leading){
                        Text("Discover Your Jogging")
                            .font(.system(size: 18, weight: .bold, design: .default))
                            .foregroundColor(.gray)
                        Text("Routes").font(.system(size: 40, weight: .bold, design: .default)).foregroundColor(Color(.label))
                    }
                    Spacer()
                    
                }.padding(.leading).padding(.top).padding(.trailing)
                
                
                //ForEach_start
                
                ForEach(self.result){ thisItem in
                    
                    GeometryReader{geo -> AnyView in
                        return AnyView(
                            
                            ZStack{
                                
                                WebImage(url: URL(string: NetworkManager.shared.urlBasePath + thisItem.background))
                                    .placeholder{
                                        Color.gray
                                    }
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width:self.SVWidth, height: self.itemHeight)
                                    .clipped()
                                    
                                    .background(Color(.systemBackground))
                                    
                                Button(action: {
                                   
                                    self.expandedItem = thisItem
                                    showBottomBar.toggle()
                                    let x = geo.frame(in: .global).minX
                                    let y = geo.frame(in: .global).minY
                                    let thisRect = CGRect(x: x,
                                                          y: y,            width:self.SVWidth,
                                                          height: self.itemHeight)
                                    self.expandedScreen_returnPoint = thisRect
                                    self.expandedScreen_startPoint =  thisRect
                                    
                                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                                        self.expandedScreen_shown = true
                                        self.expandedScreen_startPoint =  CGRect(x: 0,
                                                                                 y: 0,                                                                                    width:UIScreen.main.bounds.size.width,
                                                                                 height: UIScreen.main.bounds.size.height)
                                        
                                        
                                    }
                                }) {
                                    VStack{
                                        HStack{
                                            
                                            VStack(alignment: .leading){
                                                Text("\(thisItem.suburb)" + ", " + "\(thisItem.postcode)")
                                                    .font(.system(size: 18, weight: .bold, design: .default))
                                                    .foregroundColor(.init(white: 0.8))
                                                Text("\(thisItem.name)")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 36, weight: .bold, design: .default))
                                            }.padding()
                                            Spacer()
                                            Button(action: {
                                                context.performAndWait {
                                                    withAnimation {
                                                        thisItem.star.toggle()
                                                        try? context.save()
                                                    }
                                                }
                                                if thisItem.star{
                                                    print("liked")
                                                } else{
                                                    print("disliked")
                                                }
                                                
                                            }) {
                                                Image(systemName: thisItem.star ? "heart.fill" : "heart")
                                                    .foregroundColor(AppColor.shared.gymColor)
                                                    .font(.title)
                                                    .padding(.trailing)
                                            }
                                        }
                                        Spacer()
                                        HStack{
                                            
                                            VStack(alignment: .leading){
                                                Text("\(thisItem.intruduction)")
                                                    .lineLimit(4)
                                                    .font(.system(size: 18, weight: .bold, design: .default))
                                                    .foregroundColor(.white)
                                                
                                            }.padding()
                                            Spacer()
                                        }
                                    }.frame(width: self.SVWidth)
                                    
                                }
                                
                                
                            }
                            .cornerRadius(15).foregroundColor(.white)
                            .shadow(color: .init(red: 0.1, green: 0.1, blue: 0.1)
                                , radius: 11 , x: 0, y: 4)
                        )
                    }.background(Color.clear.opacity(0.4))
                        .frame(height:self.itemHeight)
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                        .padding(.bottom, 20)
                }.coordinateSpace(name: "forEach")
                Spacer()
                    .frame(height:60)
                //ForEach_End
            }
            .coordinateSpace(name: "RefreshControl")
            }
            else{
                VisualEffectView(effect: UIBlurEffect(style: .light))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(width: 60, height: 60, alignment: .center)
        ActivityIndicatorView(isVisible: .constant(true), type: .default)
            .frame(width: 40.0, height: 40.0)
                .foregroundColor(AppColor.shared.popularRouteColor)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
                    self.popularRoutesModel.loadPopularCardsData(location: checkUserLocation(lat: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, long: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) ? CLLocationCoordinate2D(latitude: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) : CLLocationCoordinate2D(latitude: -37.810489070978186, longitude: 144.96290632581503), context: context)
    //                if true{
    //                self.loadPopularCardsData(location: checkUserLocation(lat: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, long: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) ? CLLocationCoordinate2D(latitude: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) : CLLocationCoordinate2D(latitude: -37.810489070978186, longitude: 144.96290632581503))
    //
    //            }
                    
                }
            }
            }
            if !result.isEmpty && self.expandedItem != nil{
                GeometryReader{geo -> AnyView in
                
                
                return AnyView(
                    
                    ZStack{
                        ScrollView{
                            VStack(spacing:0){
                                ZStack{
                                    WebImage(url: URL(string: NetworkManager.shared.urlBasePath +  expandedItem!.background))
                                        .placeholder{
                                            Color.gray
                                        }
                                    .resizable()
                                    .scaledToFill()
                                    .offset(y: self.expandedScreen_shown ? 0 : 0)
                                    .frame(width:
                                        self.expandedScreen_shown ? UIScreen.main.bounds.width : self.SVWidth
                                        
                                        , height:
                                        self.itemHeight
                                )
                                    .clipped()
                                    
                                        .background(Color(.systemBackground))
                                    .foregroundColor(Color.green)
                                    .edgesIgnoringSafeArea(.top)
                                
                                VStack{
                                    HStack{
                                        
                                        VStack(alignment: .leading){
                                            Text("\(expandedItem!.suburb)" + ", " + "\(expandedItem!.postcode)")
                                                .font(.system(size: 18, weight: .bold, design: .default))
                                                .foregroundColor(.init(red: 0.8 , green: 0.8, blue: 0.8  )).opacity(1.0)
                                            Text("\(expandedItem!.name)")
                                                .font(.system(size: 36, weight: .bold, design: .default))
                                                .foregroundColor(.white)
                                        }.padding()
                                        Spacer()
                                    }.offset(y:
                                        self.expandedScreen_shown ? 44 : 0)
                                    Spacer()
                                    HStack{
                                        VStack(alignment: .leading){
                                            Text("\(expandedItem!.intruduction)")
                                                
                                                .font(.system(size: 18, weight: .bold, design: .default))
                                                .foregroundColor(.white)
                                            
                                        }.padding()
                                        Spacer()
                                    }
                                }.frame(width: self.expandedScreen_startPoint.width)
                            }.frame(height:
                                self.itemHeight
                            ).zIndex(1)
                                VStack{
                                    ZStack{
                                        VStack{
                                            ZStack{
                                                Text(expandedItem!.name)
                                                    .font(.title)
                                                    .bold()
                                                HStack{
                                                    Spacer()
                                                    Button(action: {
                                                    context.performAndWait {
                                                        withAnimation {
                                                            expandedItem!.star.toggle()
                                                            try? context.save()
                                                        }
                                                    }
                                                    if expandedItem!.star{
                                                        print("liked")
                                                    } else{
                                                        print("disliked")
                                                    }
                                                    
                                                }) {
                                                    Image(systemName: expandedItem!.star ? "heart.fill" : "heart")
                                                        .foregroundColor(AppColor.shared.gymColor)
                                                        .font(.title)
                                                        .padding(.trailing)
                                                    }.padding()
                                                    .offset(y:35)
                                                    
                                                }
                                            }
                                            .padding(.top,15)
                                            .padding(.bottom,20)
                                            HStack{
                                                Button(action: {
                                                    withAnimation(self.openCardAnimation) {
                                                        self.detailPage = 1
                                                        self.leftPercent = 0
                                                    }
                                                }, label: {
                                                    Text("Introduction")
                                                        .foregroundColor(Color(.label))
                                                        .bold()
                                                        .opacity(Double(1 - leftPercent * 0.5))
                                                })
                                                .frame(width:UIScreen.main.bounds.width/3)

                                                .padding(.horizontal)
                                                Button(action: {
                                                    withAnimation(self.openCardAnimation) {

                                                        self.detailPage = 2
                                                        self.leftPercent = 1
                                                    }
                                                }, label: {
                                                    Text("Map")
                                                        .foregroundColor(Color(.label))
                                                        .bold()
                                                        .opacity(Double(0.5 + leftPercent * 0.5))
                                                })
                                                .frame(width:UIScreen.main.bounds.width/3)
                                                .padding(.horizontal)
                                            }
                                            
                                            GeometryReader { geometry in
                                                RoundedRectangle(cornerRadius: 2)
                                                    .foregroundColor(.orange)
                                                    .frame(width: 30, height: 4)
                                                    .offset(x: (0.25 + 0.431 * self.leftPercent) * geometry.size.width)
                                            }
                                            .frame(height: 6,alignment: .center)
                                            if leftPercent == 0 {
                                                VStack{
                                                    HStack{
                                                    Text("Length")
                                                        .bold()
                                                    Text(String(round((expandedItem!.length)/1000)) + " km")
                                                    Spacer()
                                                    Text("Distance")
                                                        .bold()
                                                    Text(String(expandedItem!.distance) + " km")
                                                }
                                                    .padding(.horizontal)
                                                    HStack{
                                                        Text("Safety tips:")
                                                        .bold()
                                                        .padding(.horizontal)
                                                        .padding(.top)
                                                        Spacer()
                                                    }
                                                    Text(expandedItem!.safety_tips)
                                                        .padding(.horizontal)
                                                    HStack{
                                                        Text("Route detail:")
                                                        .bold()
                                                        .padding(.horizontal)
                                                        .padding(.top)
                                                        Spacer()
                                                    }
                                                Text(expandedItem!.detail_text)
                                                    .padding(.horizontal)
                                                    .padding(.bottom)
                                                .frame(maxHeight: self.expandedScreen_shown ? .infinity : 0)}
                                                
                                            } else{
                                                    VStack{WebImage(url: URL(string: NetworkManager.shared.urlBasePath + expandedItem!.map))
                                                        .placeholder{
                                                            Color.gray
                                                        }
                                                        .resizable()
                                                        .scaledToFill()
                                                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                                        .padding(.horizontal)
                                                        Button(action: {openMapApp(lat:expandedItem!.latitude,long:expandedItem!.longitude)}, label: {
                                                            DirectButtonView(color:.blue,text:"Let's go").padding()
                                                    })
                                                    }
                                                }
//                                            HScrollViewController(pageWidth: UIScreen.main.bounds.width,
//                                                                        contentSize: CGSize(width: UIScreen.main.bounds.width * 2, height: UIScreen.main.bounds.width),
//                                                                        leftPercent: self.$leftPercent){
//                                                    HStack(spacing:0){
//                                                                VStack{
//                                                                    HStack{
//                                                                        Text("Lenght")
//                                                                            .bold()
//                                                                        Text(String(round((joggingRoutes[thisItem].longth)/1000)) + " km")
//                                                                        Spacer()
//                                                                        Text("Distance")
//                                                                            .bold()
//                                                                        Text(String(joggingRoutes[thisItem].distance) + " km")
//                                                                    }
//                                                                        .padding(.horizontal)
//                                                                    Text(joggingRoutes[thisItem].detail_text)//
//                                                                        .padding()
//                                                                        .frame(
//                                                                        maxHeight: self.expandedScreen_shown ? .infinity : 0)
//                                                                        .foregroundColor(.blue)
//                                                                }
//
//
//                                                        VStack{
//                                                            WebImage(url: URL(string: NetworkManager.shared.urlBasePath + joggingRoutes[thisItem].map))
//                                                                .resizable()
//                                                                .scaledToFill()
//                                                                .clipShape(RoundedRectangle(cornerRadius: 25.0))
//
//
//                                                            }
//                                                        }
//                                                    }
                                                }

                                        }
                                    }
                                    
                                }
                              
                            .background(Color(.systemBackground))
                        }
                        .frame(width: self.expandedScreen_startPoint.width, height: self.expandedScreen_startPoint.height)
                        .background(Color.clear)
                        .cornerRadius(self.expandedScreen_shown ? 0 : 15 )
                        .animation(.easeInOut(duration: 0.3))
                        .offset(x: self.expandedScreen_startPoint.minX, y: self.expandedScreen_startPoint.minY)
                        
                        Button(action: {
                            self.expandedScreen_willHide = true
                            self.leftPercent = 0
                            self.expandedScreen_startPoint = self.expandedScreen_returnPoint
                            showBottomBar.toggle()
                            self.expandedScreen_shown = false
                            Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { (timer) in
                                self.expandedScreen_willHide = false
                            }
                        }){
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.init(white: 0.9))
                                .font(.system(size: 25)).padding()
                                .opacity(self.expandedScreen_shown ? 1 : 0.0)
                                .animation(
                                    Animation.easeInOut(duration: 0.3)
                            )
                            
                        }.offset(x: (UIScreen.main.bounds.width/2) - 30, y: (-1 * UIScreen.main.bounds.height/2) + 60)
                    }
                )
            }.edgesIgnoringSafeArea(.top)
                .opacity(self.expandedScreen_shown ? 1 : 0.0)
                .animation(
                    Animation.easeInOut(duration: 0.05)
                        .delay(self.expandedScreen_willHide ? 0.5 : 0)
            )}
            
        }
                ZStack{
                    if popularRoutesModel.loading{
                    VisualEffectView(effect: UIBlurEffect(style: .light))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .frame(width: 60, height: 60, alignment: .center)}
                    ActivityIndicatorView(isVisible: $popularRoutesModel.loading, type: .default)
                    .frame(width: 40.0, height: 40.0)
                    .foregroundColor(AppColor.shared.popularRouteColor)
            }
            }
            .navigationTitle("")
            .navigationBarHidden(navigationBar)
        
//        NavigationView{
//            VStack{
//                ZStack{
//                if loaded{
//
////                        TabView(selection: $selectedTab) {
////                            ForEach(self.joggingRoutes,id:\.id) { card in
////                                ////                    DirectionMapView(directions: $directionsList, coordinatesList: card.path)
////                                        RecommendedJoggingCard(JoggingRoute: card)
////
////                                                    .environmentObject(userData)
////
////
////
////                            }
////                        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
////
//                    ScrollView(showsIndicators:false){
//                            ForEach(joggingRoutes,id:\.id){ card in
//                                RecommendedJoggingCard(JoggingRoute: card)
//                            .environmentObject(userData)}
//
//                        }
//
//                }
//                ZStack{
//                    if loading{
//                        VisualEffectView(effect: UIBlurEffect(style: .light))
//                            .clipShape(RoundedRectangle(cornerRadius: 15))
//                            .frame(width: 60, height: 60, alignment: .center)}
//                    ActivityIndicatorView(isVisible: $loading, type: .default)
//                        .frame(width: 40.0, height: 40.0)
//                        .foregroundColor(AppColor.shared.joggingColor)
//                }
//            }
//
//            }
//        }
//        .navigationBarHidden(true)
        
        
//        .onAppear(perform: {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
//                self.popularRoutesModel.loadPopularCardsData(location: checkUserLocation(lat: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, long: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) ? CLLocationCoordinate2D(latitude: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) : CLLocationCoordinate2D(latitude: -37.810489070978186, longitude: 144.96290632581503), context: context)
////                if true{
////                self.loadPopularCardsData(location: checkUserLocation(lat: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, long: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) ? CLLocationCoordinate2D(latitude: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) : CLLocationCoordinate2D(latitude: -37.810489070978186, longitude: 144.96290632581503))
////
////            }
//
//            }
//
//        })
            .toast(isPresenting: $popularRoutesModel.error, duration: 1.2, tapToDismiss: true, alert: { AlertToast(type: .error(.red), title: "Network Error", subTitle: "")
        }, completion: {_ in
            self.popularRoutesModel.error = false
        })
    }
}
//
//struct PupolarJoggingPathHomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        PupolarJoggingPathHomeView(joggingRoutes: [PopularJoggingRoute(id: 0, name: "sdfasf", map: "fsdf", distance: 3.2, longth: 43.3, background: "yarra-trail.png", intruduction: """
//“The Tan” is one of the most popular running and walking trails in Melbourne, which is named for the gardens. Join the local racers on this loop around the Royal Botanical Garden of Melbourne. There are lots of shade, greenery, views of the Yarra River, and a challenging slope.
//""", suburb: "melbourne", postcode: "VIC3000", latitude: 43.3, longitude: 133.2, detail_text: """
//The “Tan” is a hugely popular gravel running route looping around Melbourne’s Royal Botanic Gardens and Kings Domain. The Domain Parklands include Kings Domain, Government House Reserve, Shrine of Remembrance Reserve and the Royal Botanic Gardens, extending to the river.
//Running the ‘Tan’ in Melbourne is a thing: the website Run The Tran is a central source for ALL official recorded run times around the 3.827 km (2.378 miles) Tan Track, plus other information and resources.
//Add-Ons: The gardens and the ornamental lake they circle are alluring, but it’s also worth checking out the World War I Shrine of Remembrance, monument to lost Oarsmen, and the Government House (where the Governor of Victoria Resides). If you’re lucky, you can catch a Quidditch match in action at the Harry Potter inspired Quidditch Park. Overall, it’s a flat, easy to navigate run that will breeze by with all the greenery and scenery.
//You can also enjoy the trails along the Yarra River.
//""", safety_tips: ""),PopularJoggingRoute(id: 1, name: "sdfasf", map: "fsdf", distance: 3.2, longth: 43.3, background: "yarra-trail.png", intruduction: """
//“The Tan” is one of the most popular running and walking trails in Melbourne, which is named for the gardens. Join the local racers on this loop around the Royal Botanical Garden of Melbourne. There are lots of shade, greenery, views of the Yarra River, and a challenging slope.
//""", suburb: "melbourne", postcode: "VIC3000", latitude: 43.3, longitude: 133.2, detail_text: """
//The “Tan” is a hugely popular gravel running route looping around Melbourne’s Royal Botanic Gardens and Kings Domain. The Domain Parklands include Kings Domain, Government House Reserve, Shrine of Remembrance Reserve and the Royal Botanic Gardens, extending to the river.
//Running the ‘Tan’ in Melbourne is a thing: the website Run The Tran is a central source for ALL official recorded run times around the 3.827 km (2.378 miles) Tan Track, plus other information and resources.
//Add-Ons: The gardens and the ornamental lake they circle are alluring, but it’s also worth checking out the World War I Shrine of Remembrance, monument to lost Oarsmen, and the Government House (where the Governor of Victoria Resides). If you’re lucky, you can catch a Quidditch match in action at the Harry Potter inspired Quidditch Park. Overall, it’s a flat, easy to navigate run that will breeze by with all the greenery and scenery.
//You can also enjoy the trails along the Yarra River.
//""", safety_tips: "")], showBottomBar: .constant(true)).environmentObject(UserData())
//    }
//}
