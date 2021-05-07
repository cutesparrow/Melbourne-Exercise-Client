//
//  BottomBarView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 25/3/21.
//

import SwiftUI
import PermissionsSwiftUI

let items: [BottomBarItem] = [
    BottomBarItem(icon: "house.fill", title: "Home", color: AppColor.shared.homeColor),
    BottomBarItem(icon: "suit.heart.fill", title: "Gyms", color: AppColor.shared.gymColor),
    //BottomBarItem(icon: "sun.min", title: "Outdoor", color: AppColor.shared.outDoorColor),
    BottomBarItem(icon: "location.north.fill", title: "Route", color: AppColor.shared.joggingColor),
    BottomBarItem(icon:"figure.walk",title: "Jog",color:AppColor.shared.popularRouteColor),
]
struct BottomBarView: View {
    @EnvironmentObject var userData:UserData
    @State var showGuideView:Bool = true
    @State var selectedIndex:Int = 0
    @State var tutorial:Bool = false
    @State var showLocationAlert:Bool = false
    @State var showBottomBar:Bool = true
    @State var showRangeAlert:Bool = false
    init() {
        UITableView.appearance().backgroundColor = .clear// Uses UIColor
    }
    var body: some View {
        if (showGuideView && userData.new) || tutorial {
            if tutorial{
                OnboardingShowView(showGuideView: $tutorial)
            }
            else{OnboardingShowView(showGuideView: $showGuideView)}
        } else {
           NavigationView{
             ZStack{
                MainSwitchView(selectView: $selectedIndex, showBottomBar:$showBottomBar, tutorial:$tutorial)
                     .environmentObject(userData)
                 VStack{
                     Spacer()
                    if showBottomBar {
                        BottomBar(selectedIndex: $selectedIndex, items: items)
                            
                    }
                 }.padding(.bottom,15)
                 .ignoresSafeArea(.all, edges: .all)
             }
             .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    if !userData.showedRangeAlert
                    {self.showRangeAlert = !checkUserLocation(lat: LocationFetcher.share.lastKnownLocation?.latitude ?? -37, long: LocationFetcher.share.lastKnownLocation?.longitude ?? 144)
                        self.userData.showedRangeAlert = true
                    }
                }
             })
             .alert(isPresented: $showRangeAlert, content: {
                Alert(title: Text("Out of Range"), message: Text("We only serve users in melbourne CBD, you are out of this range now. Your location will be set at melbourne central which is the default location, you can try all features"))
             })
             .toolbar {
                 ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    Button(action: {tutorial.toggle()}, label: {
                                             Image(systemName: "questionmark.circle")
                                                 .font(.system(size: 32, weight: .regular))
                     })
                 }
             }
         }
         .background(Color.clear)
        }
    }
    
}
struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView()
            .environmentObject(UserData())
    }
}
