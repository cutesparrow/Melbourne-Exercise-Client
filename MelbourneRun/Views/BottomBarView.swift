//
//  BottomBarView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 25/3/21.
//

import SwiftUI
import BottomBar_SwiftUI
import PermissionsSwiftUI

let items: [BottomBarItem] = [
    BottomBarItem(icon: "house.fill", title: "Home", color: AppColor.shared.homeColor),
    BottomBarItem(icon: "heart", title: "Gyms", color: AppColor.shared.gymColor),
    BottomBarItem(icon: "sun.min", title: "Outdoor", color: AppColor.shared.outDoorColor),
    BottomBarItem(icon: "figure.walk", title: "Jogging", color: AppColor.shared.joggingColor)
]

struct BottomBarView: View {
    @EnvironmentObject var userData:UserData
    @ObservedObject var locationManager = LocationManager()
    @State private var selectedIndex:Int = 0
    init() {
        UITableView.appearance().backgroundColor = .clear// Uses UIColor
    }
    var body: some View {
        NavigationView{
            ZStack{
                MainSwitchView(selectView: $selectedIndex)
                    .environmentObject(userData)
                VStack{
                    Spacer()
                    BottomBar(selectedIndex: $selectedIndex, items: items)
                    
                    
                    
                }.padding(.bottom,5)
                .ignoresSafeArea(.all, edges: .all)
            }
        }
        .JMAlert(showModal: $locationManager.permissionIsNotOk, for: [.location], autoCheckAuthorization: false)
        .changeBottomDescriptionTo("you have to enable permissions in settings,otherwise in order to provide you with all the functions of this application, we will locate your default location in Melbourne Central")
        .background(Color.clear)
    }
    
}
struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView()
            .environmentObject(UserData())
    }
}
