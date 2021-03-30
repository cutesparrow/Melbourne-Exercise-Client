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
    BottomBarItem(icon: "figure.wave", title: "Gyms", color: AppColor.shared.gymColor),
    //BottomBarItem(icon: "sun.min", title: "Outdoor", color: AppColor.shared.outDoorColor),
   // BottomBarItem(icon: "figure.walk", title: "Jogging", color: AppColor.shared.joggingColor)
]
struct BottomBarView: View {
    @EnvironmentObject var userData:UserData

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
                        .frame(width: UIScreen.main.bounds.width/1.5)
                    
                    
                }.padding(.bottom,5)
                .ignoresSafeArea(.all, edges: .all)
            }
        }
        
        .background(Color.clear)
    }
    
}
struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView()
            .environmentObject(UserData())
    }
}
