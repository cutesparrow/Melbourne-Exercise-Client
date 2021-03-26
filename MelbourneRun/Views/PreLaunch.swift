//
//  PreLaunch.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 24/3/21.
//

import SwiftUI

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
            
        }.onAppear{
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
