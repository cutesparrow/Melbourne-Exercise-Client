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
    BottomBarItem(icon: "suit.heart", title: "Gyms", color: AppColor.shared.gymColor),
    //BottomBarItem(icon: "sun.min", title: "Outdoor", color: AppColor.shared.outDoorColor),
    // BottomBarItem(icon: "figure.walk", title: "Jogging", color: AppColor.shared.joggingColor)
]
struct BottomBarView: View {
    @EnvironmentObject var userData:UserData
    @State var showGuideView:Bool = true
    @State private var selectedIndex:Int = 0
    @State var tutorial:Bool = false
    @State var showLocationAlert:Bool = false
    
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
                 MainSwitchView(selectView: $selectedIndex)
                     .environmentObject(userData)
                 VStack{
                     Spacer()
                     BottomBar(selectedIndex: $selectedIndex, items: items)
                            
                         .frame(width: UIScreen.main.bounds.width/1.5)
                     
                     
                 }.padding(.bottom,5)
                 .ignoresSafeArea(.all, edges: .all)
             }
             .alert(isPresented: $userData.showeLocationWarning, content: {
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
