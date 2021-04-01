//
//  PreLaunch.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 24/3/21.
//

import SwiftUI
import PermissionsSwiftUI


struct PreLaunch: View {
    @EnvironmentObject var userData:UserData
    @State var showMainView:Bool = false
   
    
    var body: some View {
        Group{
            if showMainView{
            BottomBarView()
                .environmentObject(userData)
        } else{
            ZStack{
                Color(.clear)
                    .edgesIgnoringSafeArea(.all)
                Image("LaunchImage")
                    .resizable()
                    .frame(width: 400, height: 350, alignment: .center)
                    .offset(y:-UIScreen.main.bounds.height/8)
            }
        }
            
        }
        .JMAlert(showModal: $userData.locationManager.permissionIsNotOk, for: [.location], autoCheckAuthorization: false)
        .changeBottomDescriptionTo("Enable permissions in settings, or default location will be set at Melbourne Central. If your current location exceeds CBD, please turn off the location permission and use the default location.")
        .onAppear{
            withAnimation(.timingCurve(1, 0.01, 0.71, 0.11, duration: 2.4)){
                showMainView = true
            }
        }
    }
}

struct PreLaunch_Previews: PreviewProvider {
    static var previews: some View {
        PreLaunch()
            .environmentObject(UserData())
    }
}
