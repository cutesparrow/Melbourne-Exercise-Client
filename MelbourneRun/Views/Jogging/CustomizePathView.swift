//
//  CustomizePathView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 9/4/21.
//

import SwiftUI
import MapKit

struct CustomizePathView: View {
    @EnvironmentObject var userData:UserData
    @State var selectedTab:Int = 0
    @State var directionsList:[String] = [""]
    @State var showDirectionsList:Bool = false
    var customizedCards:[CustomizedCard]
    var body: some View {
        VStack{
            Spacer()
            Text("Recommanded Path")
                .bold()
                .offset(y:UIScreen.main.bounds.height/30)
            TabView(selection: $selectedTab) {
                ForEach(self.customizedCards) { card in
//                    DirectionMapView(directions: $directionsList, coordinatesList: card.path)
                    PathShowView(path: card.path, height: 2.5)
                        .onTapGesture(perform: {
                            print(card.distance)
                        })
                }
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .padding(.vertical,-15)
            
            PathInformationView(imageName: "timer", text: "Time", data: self.customizedCards[selectedTab].time)
                .padding(.vertical,-15)
            PathInformationView(imageName: "playpause", text: "Length", data: String(self.customizedCards[selectedTab].distance)+" KM")
                .padding(.vertical,-15)
            PathInformationView(imageName: "pills", text: "Risk", data: self.customizedCards[selectedTab].risk)
                .padding(.vertical,-15)
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 15.0)
                        .fill(AppColor.shared.joggingColor)
                        .frame(width: 130, height: 50, alignment: .center)
                        .padding()
                    Button(action: {self.showDirectionsList.toggle()}, label: {
                        
                       HStack{
                        Image(systemName: "location.north")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                        Text("Directions")
                            .foregroundColor(Color(.white))}
                        
                    })
                    
                }
                
            }
            .padding(.vertical,-15)
           
        }
        .sheet(isPresented: $showDirectionsList, content: {
            VStack{
                Text("Directions")
                          .font(.largeTitle)
                          .bold()
                          .padding()
                Divider().background(Color.blue)
                List(self.customizedCards[selectedTab].directions, id:\.self){i in
                HTMLStringView(html: i)
                    
            }}
        })
        .onAppear(perform: {
       
        })
    }
}

