//
//  GymNewHomeView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 2/5/21.
//

import SwiftUI
import MapKit
import CoreData
import ActionOver

struct GymNewHomeView: View {
    @EnvironmentObject var userData:UserData
    @StateObject var gymsModel:GymViewModel = GymViewModel()
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: GymCore.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GymCore.distance, ascending: true)]) var result: FetchedResults<GymCore>
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -37.81145542089078, longitude: 144.96473765203163), span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015))

    
    @State private var trackingMode:MapUserTrackingMode
    @State private var search:String
//    @State private var isEditing:Bool
//    @State private var selectedGymIndex:Int
    @State private var selectedGymUid:Int
//    @State private var gotTap:Bool
    
    init() {
        self._trackingMode = State(initialValue: MapUserTrackingMode.none)
        self._search = State(initialValue: "")
//        self._isEditing = State(initialValue: false)
        self._selectedGymUid = State(initialValue: 0)
//        self._selectedGymIndex = State(initialValue: 0)
//        self._gotTap = State(initialValue: false)
    }
    
    private func findIndexOfGym(gym:GymCore) -> Int?{
        var index:Int = 0
        for i in result{
            if gym.uid == i.uid{
                return index
            }
            index += 1
        }
        return nil
    }
    
    private func findIndexOfGym(gymUid:Int) -> Int?{
        var index:Int = 0
        for i in result{
            if Int16(gymUid) == i.uid{
                return index
            }
            index += 1
        }
        return nil
    }
    
    func getGymClass() -> [ActionOverButton]{
        var classList:[String] = []
        for i in self.result{
            if !classList.contains(i.classType){
                classList.append(i.classType)
            }
        }
        classList.removeAll(where: {$0 == "Other"})
        classList = classList.sorted()
        classList.append("Other")
        classList.append("No membership")
        var membershipChooseButtons:[ActionOverButton] = []
        for i in classList{
            if i == "No membership"{
                membershipChooseButtons.append(ActionOverButton(title: i, type: .destructive, action: {
                    userData.hasMemberShip = i
                    UserDefaults.standard.set(i,forKey: "membership")
                }))
            }
            else {
                membershipChooseButtons.append(ActionOverButton(title: i, type: .normal, action: {
                userData.hasMemberShip = i
                UserDefaults.standard.set(i,forKey: "membership")
            }))}
        }
        return membershipChooseButtons
    }
    
    func checkLocationNear(gymLocation:CLLocationCoordinate2D) -> Bool {
        
        let latitudeDistance = abs(gymLocation.latitude - self.region.center.latitude)
        let longitudeDistance = abs(gymLocation.longitude - self.region.center.longitude)
        
        if latitudeDistance < self.region.span.latitudeDelta/3 && longitudeDistance < region.span.longitudeDelta/2 {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        let membershipChooseButtons:[ActionOverButton] = getGymClass()
        
        if !result.isEmpty{
            ZStack{
                Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $trackingMode, annotationItems: result.filter({userData.hasMemberShip == "No membership" ? true : $0.classType == userData.hasMemberShip}).filter({search == "" ? true : ($0.name.localizedCaseInsensitiveContains(search)) || ($0.address.localizedCaseInsensitiveContains(search)) || ($0.classType.localizedCaseInsensitiveContains(search)) || (search.caseInsensitiveCompare("star") == .orderedSame ? $0.star : false)})
//                        .filter({checkLocationNear(gymLocation: CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.long))})
                    , annotationContent: { mark in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: mark.lat, longitude: mark.long)) {
                            Button {
                                withAnimation {
                                    self.selectedGymUid = Int(mark.uid)
                                }
                        } label: {
                            RoundedGymIconOnMapView(name:mark.name)
                                .clipShape(Circle())
                                    .overlay(Circle().stroke(selectedGymUid == Int(mark.uid) ? Color(.green).opacity(0.5) : AppColor.shared.joggingColor.opacity(0.5),lineWidth: 1.4))
                                .scaleEffect(selectedGymUid == Int(mark.uid) ? 2 : 1)
                                .shadow(radius: 5)
                        }
                    }
                })
                .ignoresSafeArea()
                VStack{
                    ZStack{
                        VisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial))
                            .frame(height: 100, alignment: .center)
                            .ignoresSafeArea(.all, edges: .top)
                        HStack{
                            SearchBar(text: $search)
                            .offset(x: 0, y: 20)
                            Button(action: {userData.showMemberShipSelection.toggle()}, label: {
                                                        VStack{
                                                        Image(systemName: "list.bullet")
                                                            .foregroundColor(AppColor.shared.gymColor)
                                                            .font(.system(size: 28, weight: .regular))
        //
                                                        }
                                                        .frame(width: 50, height: 50, alignment: .center)
                                                        .padding(5)
                            }).offset(x: 0, y: 20)
                            
                        }
                    }.frame(height: 100, alignment: .center)
                    .ignoresSafeArea(.all, edges: .top)
                    Spacer()
                    GymListCardTabView(classType: userData.hasMemberShip, search: $search, selectedGymUid: $selectedGymUid)
                        .padding(.bottom,60)
                }
        }
            .actionOver(presented: $userData.showMemberShipSelection, title: "Choose your membership", message: "please select your membership of gym", buttons: membershipChooseButtons, ipadAndMacConfiguration: .init(anchor: nil, arrowEdge: nil))
            .navigationTitle("")
            .navigationBarHidden(true)
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline:.now()+0.5){selectedGymUid = Int(result.filter({userData.hasMemberShip == "No membership" ? true : $0.classType == userData.hasMemberShip})[0].uid)}
            })
            .onChange(of: selectedGymUid, perform: { value in
                DispatchQueue.main.async{
                    withAnimation{
                    region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: result[findIndexOfGym(gymUid: selectedGymUid)!].lat-0.003, longitude: result[findIndexOfGym(gymUid: selectedGymUid)!].long), span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015))
                    }
                }
            })
        }
        else{
            Color(.clear)
                .navigationTitle("")
                .navigationBarHidden(true)
                .onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
                            self.gymsModel.loadGymListData(location: checkUserLocation(lat: LocationFetcher.share.lastKnownLocation?.latitude ?? -37.810489070978186, long: LocationFetcher.share.lastKnownLocation?.longitude ?? 144.96290632581503) ? CLLocationCoordinate2D(latitude: LocationFetcher.share.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: LocationFetcher.share.lastKnownLocation?.longitude ?? 144.96290632581503) : CLLocationCoordinate2D(latitude: -37.810489070978186, longitude: 144.96290632581503), context: context)
                    
                }
                })
        }
    }
    
}

