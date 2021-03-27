//
//  MainSwitchView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 25/3/21.
//

import SwiftUI

struct MainSwitchView: View {
    @EnvironmentObject var userData:UserData
    @Binding var selectView:Int
    var body: some View {
        switch selectView {
        case 0:HomeView()
            .environmentObject(userData)
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.large)
        case 1:GymHomeView()
            .environmentObject(userData)
            
        case 2:OutDoorHomeView()
            .environmentObject(userData)
        case 3:JoggingHomeView()
            .environmentObject(userData)
        default: Text("error")
        }
    }
}

struct MainSwitchView_Previews: PreviewProvider {
    static var previews: some View {
        MainSwitchView(selectView: .constant(0))
            .environmentObject(UserData())
    }
}
