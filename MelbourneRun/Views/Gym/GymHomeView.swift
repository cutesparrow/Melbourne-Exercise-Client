//
//  GymHomeView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 23/3/21.
//

import SwiftUI
import MapKit
import ActionOver




struct GymHomeView: View {
    @EnvironmentObject var userData:UserData
    
    @State var gymList:GymList = GymList(list: [])
    
    var body: some View {
        let membershipChooseButtons:[ActionOverButton] = getGymClass()
            return Group{
            GymListView(gymList:$gymList)
            .padding(.bottom,0)
            .environmentObject(userData)
//            .onAppear(perform: {
//                self.userData.getGymList(location: checkUserLocation(lat: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, long: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) ? CLLocationCoordinate2D(latitude: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) : CLLocationCoordinate2D(latitude: -37.810489070978186, longitude: 144.96290632581503))
//            })
            .listStyle(PlainListStyle())
            .ignoresSafeArea(.all, edges: .all)
            .frame(width: UIScreen.main.bounds.width)
        }
            .actionOver(presented: $userData.showMemberShipSelection, title: "Choose your membership", message: "please select your membership of gym", buttons: membershipChooseButtons, ipadAndMacConfiguration: .init(anchor: nil, arrowEdge: nil))
        .navigationTitle("Gyms")
        .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    Button(action: {userData.showMemberShipSelection = true}, label: {
                                                VStack{
                                                Image(systemName: "person.circle")
                                                    .font(.system(size: 32, weight: .regular))
//                                                Text("Membership")
//                                                    .font(.caption2)
                                            }
                    })
                }
            }
//            .navigationBarLargeTitleItems(trailing:
//                    Button(action: {userData.showMemberShipSelection = true}, label: {
//                        if userData.currentPage == 1{
//                            VStack{
//                            Image(systemName: "person.circle")
//                                .font(.system(size: 20, weight: .regular))
//                            Text("Membership")
//                                .font(.caption2)
//                        }.padding(.trailing,20)}
//                        else{
//
//                            Text(String(userData.currentPage))
//                        }
//
//                    }))

       
        
    }
    func getGymClass() -> [ActionOverButton]{
        var classList:[String] = []
        for i in self.gymList.list{
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
            else {membershipChooseButtons.append(ActionOverButton(title: i, type: .normal, action: {
                userData.hasMemberShip = i
                UserDefaults.standard.set(i,forKey: "membership")
            }))}
        }
        return membershipChooseButtons
    }
}

