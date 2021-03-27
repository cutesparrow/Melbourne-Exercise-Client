//
//  PlanView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 22/3/21.
//

import SwiftUI

struct PlanView: View {
    @EnvironmentObject var userDate:UserData
    @Binding var isShown:Bool
    var body: some View {
        VStack{
            RoadSituationContentView(day: 0)
            .environmentObject(userDate)
            .padding()
            
            
        HStack{
            Spacer()
            Button(action: {isShown.toggle()}, label: {
                DirectButtonView(color: Color.gray, text: "Cancel")
            })
            Spacer()
            Button(action: {}, label: {
                DirectButtonView(color: AppColor.shared.gymColor, text: "Plan")
            })
            Spacer()
        }
        }.frame(width:UIScreen.main.bounds.width)
}
}

struct PlanView_Previews: PreviewProvider {
    static var previews: some View {
        PlanView(isShown: .constant(false)).environmentObject(UserData())
    }
}
