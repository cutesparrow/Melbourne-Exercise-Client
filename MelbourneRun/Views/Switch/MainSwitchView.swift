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
    @Binding var showBottomBar:Bool
    @Binding var tutorial:Bool 
//    @State var showInformation:ShowInformation = ShowInformation(imageName: "", safetyTips: "", exerciseTips: "", exerciseBenefits: "")
//    @State var gymList:GymList = GymList(list: [])
    var body: some View {
        switch selectView {
        case 0:HomeView(tutorial:$tutorial,bottomBarSelected:$selectView)
            .environmentObject(userData)
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        case 1:GymHomeView()
            .environmentObject(userData)
        case 2:JoggingHomeView()
            .environmentObject(userData)
            .navigationBarHidden(true)
        case 3:
            PupolarJoggingPathHomeView(showBottomBar:$showBottomBar)
                .environmentObject(userData)
                .navigationBarHidden(true)
           
                
        default: Text("error")
        }
    }
}


