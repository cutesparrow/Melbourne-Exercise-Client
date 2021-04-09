//
//  PopularPathView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 9/4/21.
//

import SwiftUI

struct PopularPathView: View {
    @EnvironmentObject var userData:UserData
    @State var selectedTab:Int = 0
    var body: some View {
        VStack{
            Spacer()
            Text("Popular Path")
                .bold()
                .offset(y:UIScreen.main.bounds.height/30)
            TabView(selection: $selectedTab) {
                ForEach(userData.cards.popularCards) { card in
                    PathShowView(path: card.path, height: 3)
                        .onTapGesture(perform: {
                            print(card.distance)
                        })
                }
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .padding(.vertical,-15)
            
            PathInformationView(imageName: "timer", text: "Time", data: userData.cards.popularCards[selectedTab].time)
                .padding(.vertical,-15)
            PathInformationView(imageName: "playpause", text: "Length", data: String(userData.cards.popularCards[selectedTab].distance)+" KM")
                .padding(.vertical,-15)
            PathInformationView(imageName: "pills", text: "Risk", data: userData.cards.popularCards[selectedTab].risk)
                .padding(.vertical,-15)
            PathInformationView(imageName: "arrowshape.turn.up.forward", text: "Distance", data: String(userData.cards.popularCards[selectedTab].distanceToUser)+" KM")
                .padding(.vertical,-15)
            PathInformationStarView(imageName: "suit.heart", text: "Stars", starNumber: userData.cards.popularCards[selectedTab].popularStar)
                .padding(.vertical,-15)
        }
    }
}

struct PopularPathView_Previews: PreviewProvider {
    static var previews: some View {
        PopularPathView()
            .environmentObject(UserData())
    }
}
