//
//  CustomizePathView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 9/4/21.
//

import SwiftUI
import MapKit
import SDWebImageSwiftUI
import URLImage

struct CustomizePathView: View {
    @EnvironmentObject var userData:UserData
    @State var selectedTab:Int = 0
    @State var showDirectionsList:Bool = false
    @State var customizedCards:[CustomizedCard]
    var body: some View {
        VStack{
            Spacer()
            HStack{
                VStack(alignment: .leading){
                    Text("Discover Your Walking")
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .foregroundColor(.gray)
                    Text("Routes").font(.system(size: 40, weight: .bold, design: .default)).foregroundColor(.black)
                }
                Spacer()
                
            }.padding(.leading).padding(.top).padding(.trailing)
            
            
            TabView(selection: $selectedTab) {
                ForEach(self.customizedCards,id:\.id) { card in
//                    DirectionMapView(directions: $directionsList, coordinatesList: card.path)
                    WebImage(url: URL(string: NetworkManager.shared.urlBasePath + card.image))
                        .placeholder{
                            Color.gray
                        }
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width/1.2,height:UIScreen.main.bounds.width/1.8)
                        .clipped()
                        .cornerRadius(14)
                        .shadow(radius: 4)
                        .tag(card.id)
                        
                }
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .padding(.vertical,-15)
            
            PathInformationView(imageName: "timer", text: "Time", data: self.customizedCards[selectedTab].time)
                .padding(.vertical,-15)
            PathInformationView(imageName: "playpause", text: "Length", data: String(self.customizedCards[selectedTab].distance)+" KM")
                .padding(.vertical,-15)
            PathInformationView(imageName: "pills", text: "Risk", data: self.customizedCards[selectedTab].risk+" risk")
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
                
                List(self.customizedCards[selectedTab].instructions, id:\.self){i in
                    Text(i)
                    
            }}
        })
        .onAppear(perform: {
       
        })
    }
}

