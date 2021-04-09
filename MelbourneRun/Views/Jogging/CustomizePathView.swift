//
//  CustomizePathView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 9/4/21.
//

import SwiftUI

struct CustomizePathView: View {
    @EnvironmentObject var userData:UserData
    @State var selectedTab:Int = 0
    var body: some View {
        VStack{
            Spacer()
            Text("Recommanded Path")
                .bold()
                .offset(y:UIScreen.main.bounds.height/30)
            TabView(selection: $selectedTab) {
                ForEach(userData.cards.customizedCards) { card in
                    PathShowView(path: card.path, height: 2)
                        .onTapGesture(perform: {
                            print(card.distance)
                        })
                }
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .padding(.vertical,-15)
            
            PathInformationView(imageName: "timer", text: "Time", data: userData.cards.customizedCards[selectedTab].time)
                .padding(.vertical,-15)
            PathInformationView(imageName: "playpause", text: "Length", data: String(userData.cards.customizedCards[selectedTab].distance)+" KM")
                .padding(.vertical,-15)
            PathInformationView(imageName: "pills", text: "Risk", data: userData.cards.customizedCards[selectedTab].risk)
                .padding(.vertical,-15)
        }
    }
}

struct CustomizePathView_Previews: PreviewProvider {
    static var previews: some View {
        CustomizePathView()
            .environmentObject(UserData())
    }
}
