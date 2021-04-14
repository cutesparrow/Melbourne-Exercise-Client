//
//  PopularPathView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 9/4/21.
//

import SwiftUI
import MapKit

struct PopularPathView: View {
    @EnvironmentObject var userData:UserData
    @State var selectedTab:Int = 0
    var popularCards:[PopularCard] //TODO
    var body: some View {
        VStack{
            Spacer()
            Text("Popular Path")
                .bold()
                .offset(y:UIScreen.main.bounds.height/30)
            TabView(selection: $selectedTab) {
                ForEach(self.popularCards) { card in
                    PathShowView(path: card.path, height: 3)
                        .onTapGesture(perform: {
                            print(card.distance)
                        })
                }
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .padding(.vertical,-15)
            
            PathInformationView(imageName: "timer", text: "Time", data: self.popularCards[selectedTab].time)
                .padding(.vertical,-15)
            PathInformationView(imageName: "playpause", text: "Length", data: String(self.popularCards[selectedTab].distance)+" KM")
                .padding(.vertical,-15)
            PathInformationView(imageName: "pills", text: "Risk", data: self.popularCards[selectedTab].risk)
                .padding(.vertical,-15)
            PathInformationView(imageName: "arrowshape.turn.up.forward", text: "Distance", data: String(self.popularCards[selectedTab].distanceToUser)+" KM")
                .padding(.vertical,-15)
            PathInformationStarView(imageName: "suit.heart", text: "Stars", starNumber: self.popularCards[selectedTab].popularStar)
                .padding(.vertical,-15)
        }
    }
}

