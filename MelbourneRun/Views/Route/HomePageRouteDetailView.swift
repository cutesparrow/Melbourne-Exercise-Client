//
//  HomePageRouteDetailView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 27/4/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomePageRouteDetailView: View {
    @EnvironmentObject var userData:UserData
    @State var showDirectionsList:Bool = false
    @ObservedObject var route:RouteCore
    @Environment(\.managedObjectContext) var context
    var body: some View {
        VStack{
            Spacer()
            HStack{
                VStack(alignment: .leading){
                    route.type == "Walking & Dog" ? Text("Discover Your Walking").font(.system(size: 18, weight: .bold, design: .default))
                        .foregroundColor(.gray) : Text("Discover Your Cycling").font(.system(size: 18, weight: .bold, design: .default))
                        .foregroundColor(.gray)
                        
                    Text("Routes").font(.system(size: 40, weight: .bold, design: .default)).foregroundColor(.black)
                }
                Spacer(minLength: 0)
                ZStack{
                    RoundedRectangle(cornerRadius: 15.0)
                        .fill(AppColor.shared.joggingColor)
                        .frame(width: 120, height: 50, alignment: .center)
                        .padding(.vertical)
                    Button(action: {self.showDirectionsList.toggle()}, label: {
                        
                       HStack{
                        Image(systemName: "location.north")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                        Text("Directions")
                            .foregroundColor(Color(.white))}
                    })
                }
            }.padding(.leading).padding(.top).padding(.trailing)
            
//                    DirectionMapView(directions: $directionsList, coordinatesList: card.path)
                    WebImage(url: URL(string: NetworkManager.shared.urlBasePath + route.mapImage!))
                        .placeholder{
                            Color.gray
                        }
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width/1.2,height:UIScreen.main.bounds.width/1.8)
                        .clipped()
                        .cornerRadius(14)
                        .shadow(radius: 4)
                        .padding(.bottom)
                        
            PathInformationView(imageName: "timer", text: "Time", data: self.route.time!)
                .padding(.vertical,-15)
            PathInformationView(imageName: "playpause", text: "Length", data: String(self.route.length)+" KM")
                .padding(.vertical,-15)
            if self.route.type == "Walking & Dog"{PathInformationView(imageName: "pills", text: "Risk", data: self.route.risk!+" risk")
                .padding(.vertical,-15)}
            HStack{
                
            }
            .padding(.vertical,-15)
           
        }.sheet(isPresented: $showDirectionsList, content: {
            VStack{
                Text("Directions")
                          .font(.largeTitle)
                          .bold()
                          .padding()
                
                List(self.route.directions!.sortedArray(using: [NSSortDescriptor(keyPath: \ImageCore.uid, ascending: true)]) as! [Direction], id:\.self){i in
                    Text(i.directionSentence!)
            }}
        })
    }
}


