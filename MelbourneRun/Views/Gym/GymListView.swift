//
//  GymListView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 18/3/21.
//

import SwiftUI
import MapKit
import SwiftUIRefresh
import ActivityIndicatorView
import AlertToast
import CoreData

struct GymListView: View {
    @EnvironmentObject var userData:UserData
    @StateObject var gymsModel:GymViewModel = GymViewModel()
    @State private var isShowing = false
    @State private var showLoadingIndicator = false
    @State private var networkError:Bool = false
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: GymCore.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GymCore.distance, ascending: true)]) var result: FetchedResults<GymCore>
    
//    func saveData(context:NSManagedObjectContext){
//        self.gymList.list.forEach { (data) in
//            let entity = GymCore(context: context)
//            entity.address = data.address
//            entity.uid = Int16(data.id)
//            entity.classType = data.classType
//            entity.distance = data.distance
//            entity.lat = data.lat
//            entity.long = data.long
//            entity.limitation = Int16(data.limitation)
//            entity.name = data.name
//            data.Images.forEach { (image) in
//                let imageCore = ImageCore(context: context)
//                imageCore.name = image
//                imageCore.uid = Int16(data.Images.firstIndex(where: { $0 == image })!)
//                entity.addToImages(imageCore)
//
//            }
//        }
//        do {
//            try context.save()
//            print("success")
//        } catch  {
//            print(error.localizedDescription)
//        }
//
//    }
//
//    func loadGymListData(location:CLLocationCoordinate2D,context:NSManagedObjectContext){
//        let completion: (Result<GymList, Error>) -> Void = { result in
//            switch result {
//            case let .success(list):
//                self.gymList = list
//                self.saveData(context: context)
//                self.showLoadingIndicator = false
//            case let .failure(error): print(error)
//                self.showLoadingIndicator = false
//                self.networkError = true
//            }
//        }
//        self.showLoadingIndicator = true
//        _ = NetworkAPI.loadGymList(location: location, completion: completion)
//    }
    func scaleValue(mainFrame : CGFloat,minY : CGFloat)-> CGFloat{
        
   
        
        withAnimation(.easeOut){
            
          
            
            let scale = (minY - 25) / mainFrame
            
           
            if scale > 1{
                
                return 1
            }
            else{
                
                return scale
            }
        }
    }
    var body: some View {
            
            
        if !result.isEmpty{
            VStack(spacing: 0){
                
                HStack{
                    Text("Gyms")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(Color(.label))
                    
                    Spacer(minLength: 0)
                    Button(action: {userData.showMemberShipSelection = true}, label: {
                                                VStack{
                                                Image(systemName: "list.bullet")
                                                    .foregroundColor(AppColor.shared.gymColor)
                                                    .font(.system(size: 28, weight: .regular))
//                                                Text("Membership")
//                                                    .font(.caption2)
                                            }
                    })
                }
                .padding()
                
                .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                .background(Color(.systemBackground).shadow(color: Color.black.opacity(0.18), radius: 5, x: 0, y: 5))
                .zIndex(0)
                
                
                GeometryReader{mainView in
                    
                    ScrollView{
                        
                        VStack(spacing: 15){
                            
                            
                            
                            ForEach(self.result){gym in
                                
                             
                                if gym.classType == userData.hasMemberShip || userData.hasMemberShip == "No membership"{
                                GeometryReader{item in
                                    
                                    GymCellView(gym: gym)
                                        
                                        .scaleEffect(scaleValue(mainFrame: mainView.frame(in: .global).minY, minY: item.frame(in: .global).minY),anchor: .bottom)
                  
                                        .opacity(Double(scaleValue(mainFrame: mainView.frame(in: .global).minY, minY: item.frame(in: .global).minY)))
                                }
                                
                                .frame(height: 100)}
                            }
                            Spacer()
                                .frame(height:85)
                        }
                        .padding(.horizontal)
                        .padding(.top,25)
                    }
                    .zIndex(1)
                }
            }
            .background(Color(.label).opacity(0.06).edgesIgnoringSafeArea(.all))
            .edgesIgnoringSafeArea(.top)
            .navigationTitle("")
            .navigationBarHidden(true)
//
//                List{
//                    ForEach(self.result) { gym in
//                        if gym.classType == userData.hasMemberShip || userData.hasMemberShip == "No membership" {
//                        ZStack{
//                            GymCellView(gym: gym)
//                        .padding(.top,10)
//                        .padding(.bottom,10)
//                        .shadow(radius: 0 )
//                            NavigationLink(destination: GymRecordView(fetchedGym:gym)) {
//
//                            }.opacity(0)
//
//                        }
//
//                    }
//            }
//            }
                
            
            .toast(isPresenting: $networkError, duration: 1.2, tapToDismiss: true, alert: { AlertToast(type: .error(.red), title: "Network Error", subTitle: "")
            }, completion: {_ in
                self.networkError = false
            })
            
//            .pullToRefresh(isShowing: $isShowing) {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                    self.gymsModel.reloadGymListData(location: checkUserLocation(lat: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, long: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) ? CLLocationCoordinate2D(latitude: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) : CLLocationCoordinate2D(latitude: -37.810489070978186, longitude: 144.96290632581503), context: context)
//                    isShowing = false
//                }
//            }.onChange(of: self.isShowing) { value in
//            }
            
        }
        else{
                    VisualEffectView(effect: UIBlurEffect(style: .light))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .frame(width: 60, height: 60, alignment: .center)
            ActivityIndicatorView(isVisible: .constant(true), type: .default)
                .frame(width: 40.0, height: 40.0)
                    .foregroundColor(AppColor.shared.gymColor)
                .onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
                 
                            self.gymsModel.loadGymListData(location: checkUserLocation(lat: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, long: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) ? CLLocationCoordinate2D(latitude: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) : CLLocationCoordinate2D(latitude: -37.810489070978186, longitude: 144.96290632581503), context: context)
                    
                }
                })
                .navigationTitle("")
                .navigationBarHidden(true)
        }
    }
    
    
}

struct GymListView_Previews: PreviewProvider {
    static let data = UserData()
    static var previews: some View {
        GymListView()
            .environmentObject(data)
            
            
    }
}

