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
//    @State var showInformation:ShowInformation = ShowInformation(imageName: "", safetyTips: "", exerciseTips: "", exerciseBenefits: "")
//    @State var gymList:GymList = GymList(list: [])
    var body: some View {
        switch selectView {
        case 0:HomeView()
            .environmentObject(userData)
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        case 1:GymHomeView()
            .environmentObject(userData)
        case 2:JoggingHomeView()
            .environmentObject(userData)
            .navigationBarHidden(true)
        case 3:OutDoorHomeView()
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
