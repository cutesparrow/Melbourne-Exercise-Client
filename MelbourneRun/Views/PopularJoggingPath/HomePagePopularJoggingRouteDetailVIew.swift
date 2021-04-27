//
//  HomePagePopularJoggingRouteDetailVIew.swift
//  MelbExercise
//
//  Created by gaoyu shi on 27/4/21.
//

import SwiftUI
import SDWebImageSwiftUI
import MapKit
import SSToastMessage
import AlertToast
import ActivityIndicatorView
import SwiftUIRefresh

struct HomePagePopularJoggingRouteDetailVIew: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var popularRoute:PopularRouteCore
    @EnvironmentObject var userData:UserData
    @State var detailPage:Int = 1
    @Environment(\.managedObjectContext) var context
    @State var expandedScreen_startPoint = CGRect(x: 0, y: 0, width: 100, height: 100)
    @State var expandedScreen_returnPoint = CGRect(x: 0, y: 0, width: 100, height: 100)
    @State var expandedScreen_shown = true
    @State var expandedScreen_willHide = false
    @State var leftPercent: CGFloat = 0
    let openCardAnimation = Animation.timingCurve(0.7, -0.35, 0.2, 0.9, duration: 0.45)
    let itemHeight:CGFloat = 500
    let imageHeight:CGFloat = 400
    let SVWidth = UIScreen.main.bounds.width - 40
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
    var body: some View {
        
        GeometryReader{geo -> AnyView in
        return AnyView(
            
            ZStack{
                ScrollView{
                    VStack(spacing:0){
                        ZStack{
                            WebImage(url: URL(string: NetworkManager.shared.urlBasePath +  popularRoute.background))
                                .placeholder{
                                    Color.gray
                                }
                            .resizable()
                            .scaledToFill()
//                            .offset(y: self.expandedScreen_shown ? 0 : 0)
                            .frame(width:
                                self.expandedScreen_shown ? UIScreen.main.bounds.width : self.SVWidth
                                
                                , height:
                                self.itemHeight
                        )
                            .clipped()
                            
                            .background(Color.white)
                            .foregroundColor(Color.green)
                            .edgesIgnoringSafeArea(.top)
                        
                        VStack{
                            HStack{
                                
                                VStack(alignment: .leading){
                                    Text("\(popularRoute.suburb)" + ", " + "\(popularRoute.postcode)")
                                        .font(.system(size: 18, weight: .bold, design: .default))
                                        .foregroundColor(.init(red: 0.8 , green: 0.8, blue: 0.8  )).opacity(1.0)
                                    Text("\(popularRoute.name)")
                                        .font(.system(size: 36, weight: .bold, design: .default))
                                        .foregroundColor(.white)
                                }.padding()
                                Spacer()
                            }.offset(y:
                                self.expandedScreen_shown ? 44 : 0)
                            Spacer()
                            HStack{
                                VStack(alignment: .leading){
                                    Text("\(popularRoute.intruduction)")
                                        
                                        .font(.system(size: 18, weight: .bold, design: .default))
                                        .foregroundColor(.white)
                                    
                                }.padding()
                                Spacer()
                            }
                        }.frame(width: UIScreen.main.bounds.size.width)
                    }.frame(height:
                        self.itemHeight
                    ).zIndex(1)
                        VStack{
                            ZStack{
                                VStack{
                                    ZStack{
                                        Text(popularRoute.name)
                                            .font(.title)
                                            .bold()
                                        HStack{
                                            Spacer()
                                            Button(action: {
                                                self.presentationMode.wrappedValue.dismiss()
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                    context.performAndWait {
                                                    withAnimation{popularRoute.star.toggle()
                                                    try? context.save()}
                                            }
                                                    if popularRoute.star{
                                                        print("liked")
                                                    } else{
                                                        print("disliked")
                                                    }
                                                }
                                            
                                            
                                        }) {
                                            Image(systemName: popularRoute.star ? "heart.fill" : "heart")
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
                                            Text(String(round((popularRoute.length)/1000)) + " km")
                                            Spacer()
                                            Text("Distance")
                                                .bold()
                                            Text(String(popularRoute.distance) + " km")
                                        }
                                            .padding(.horizontal)
                                            HStack{
                                                Text("Safety tips:")
                                                .bold()
                                                .padding(.horizontal)
                                                .padding(.top)
                                                Spacer()
                                            }
                                            Text(popularRoute.safety_tips)
                                                .padding(.horizontal)
                                            HStack{
                                                Text("Route detail:")
                                                .bold()
                                                .padding(.horizontal)
                                                .padding(.top)
                                                Spacer()
                                            }
                                        Text(popularRoute.detail_text)
                                            .padding(.horizontal)
                                            .padding(.bottom)
                                        .frame(maxHeight: self.expandedScreen_shown ? .infinity : 0)}
                                        
                                    } else{
                                            VStack{WebImage(url: URL(string: NetworkManager.shared.urlBasePath + popularRoute.map))
                                                .placeholder{
                                                    Color.gray
                                                }
                                                .resizable()
                                                .scaledToFill()
                                                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                                .padding(.horizontal)
                                                Button(action: {openMapApp(lat:popularRoute.latitude,long:popularRoute.longitude)}, label: {
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
                        .background(Color.white)
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-30)
                .background(Color.clear)
                .cornerRadius(self.expandedScreen_shown ? 0 : 15 )
                .animation(.easeInOut(duration: 0.3))
                .offset(y: -45)
            }
        )
    }
    }
}


