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
//    @State var showDirectionsList:Bool = false
    @ObservedObject var route:RouteCore
    @Binding var showDetail:Bool
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentationMode
    @State var showDetailMapView:Bool = false
    var body: some View {
        VStack{
//            HStack{
//                VStack(alignment: .leading){
//                    route.type == "Walking & Dog" ? Text("Discover Your Walking").font(.system(size: 18, weight: .bold, design: .default))
//                        .foregroundColor(.gray) : Text("Discover Your Cycling").font(.system(size: 18, weight: .bold, design: .default))
//                        .foregroundColor(.gray)
//
//                    Text("Routes").font(.system(size: 40, weight: .bold, design: .default)).foregroundColor(Color(.label))
//                }
//                Spacer(minLength: 0)
//                ZStack{
//                    RoundedRectangle(cornerRadius: 15.0)
//                        .fill(AppColor.shared.joggingColor)
//                        .frame(width: 120, height: 50, alignment: .center)
//                        .padding(.vertical)
//                    Button(action: {self.showDirectionsList.toggle()}, label: {
//
//                       HStack{
//                        Image(systemName: "location.north")
//                            .foregroundColor(.white)
//                            .font(.system(size: 24))
//                        Text("Directions")
//                            .foregroundColor(Color(.white))}
//                    })
//                }
//                Button(action: {
//
//                    showDetail.toggle()
//
//                }, label: {
//
//                            Image(systemName: "xmark.circle.fill")
//                                .foregroundColor(Color(.label).opacity(0.8))
//                                .font(.system(size: 32)).padding()
//
//
//                })
//            }.padding(.leading).padding(.top).padding(.trailing)
//
//                    DirectionMapView(directions: $directionsList, coordinatesList: card.path)
                    ZStack{
                        WebImage(url: URL(string: NetworkManager.shared.urlBasePath + route.mapImage))
                        .placeholder{
                            Color.gray
                        }
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width/1.2,height:UIScreen.main.bounds.width/1.8)
                        .clipped()
                        .cornerRadius(14)
//                            .onTapGesture {
//                                print("tap")
//                                self.showDetailMapView.toggle()
//                            }
                        .shadow(radius: 4)
                        
                        Button(action: {
                            showDetail.toggle()
                        }, label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(Color(.black).opacity(0.8))
                                        .font(.system(size: 32)).padding()


                        }).offset(x: UIScreen.main.bounds.width/2 - 60, y: -75)
                    }
                        
            NarrowPathInformationView(imageName: "timer", text: "Time", data: self.route.time)
                .padding(.vertical,-15)
            NarrowPathInformationView(imageName: "playpause", text: "Distance", data: String(self.route.length)+" KM")
                .padding(.vertical,-15)
            if self.route.type == "Walking & Dog"{NarrowPathInformationView(imageName: "pills", text: "Risk", data: self.route.risk.uppercased()+" RISK")
                .padding(.vertical,-15)}
            HStack{
//                ZStack{
//                    RoundedRectangle(cornerRadius: 15.0)
//                        .fill(AppColor.shared.joggingColor)
//                        .frame(width: 120, height: 50, alignment: .center)
//                        .padding(.vertical)
//                    Button(action: {self.showDirectionsList.toggle()}, label: {
//
//                       HStack{
//                        Image(systemName: "location.north")
//                            .foregroundColor(.white)
//                            .font(.system(size: 24))
//                        Text("Directions")
//                            .foregroundColor(Color(.white))}
//                    })
//                }
//                .padding()
                
//                ZStack{
//                    RoundedRectangle(cornerRadius: 15.0)
//                        .fill(Color(.gray))
//                        .frame(width: 120, height: 50, alignment: .center)
//                        .padding(.vertical)
//                    Button(action: {
//                        withAnimation{
//                            showDetail.toggle()
//                        }
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {context.performAndWait {
//                            withAnimation {
//                                context.delete(route)
//                                try? context.save()
//                            }
//                        }}
//                    }, label: {
//
//                       HStack{
//                        Image(systemName: "heart.fill")
//                            .foregroundColor(AppColor.shared.gymColor)
//                            .font(.system(size: 24))
//                        Text("Cancel")
//                            .foregroundColor(Color(.white))}
//                    })
//                }.padding()
                Button(action: {
                    withAnimation{
                        showDetail.toggle()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {context.performAndWait {
                        withAnimation {
                            context.delete(route)
                            try? context.save()
                        }
                    }}
                }, label: {
//                        DetailPageButton(icon: "arrow.up.circle", color: .blue, text: "GO")
                    HStack{
                        Image(systemName: "heart.fill")
                            .font(.system(size: 16,weight: .regular))
                            .foregroundColor(Color(.white))
                        Text("Cancel")
                            .foregroundColor(Color(.white))
                    }.padding(.horizontal)
                    .padding(.vertical,5)
                }).background(Capsule().fill(Color(.systemGray3)))
                
                Spacer()
                    .frame(width: 15,alignment: .center)
                Button(action: {
                    self.showDetailMapView.toggle()
                }, label: {
//                        DetailPageButton(icon: "arrow.up.circle", color: .blue, text: "GO")
                    HStack{
                        Image(systemName: "arrow.triangle.turn.up.right.diamond.fill")
                            .font(.system(size: 16,weight: .regular))
                            .foregroundColor(Color(.white))
                        Text("Show Map")
                            .foregroundColor(Color(.white))
                    }.padding(.horizontal)
                    .padding(.vertical,5)
                }).background(Capsule().fill(Color.blue))
                
//                ZStack{
//                    RoundedRectangle(cornerRadius: 15.0)
//                        .fill(AppColor.shared.joggingColor)
//                        .frame(width: 120, height: 50, alignment: .center)
//                        .padding(.vertical)
//                    Button(action: {self.showDirectionsList.toggle()}, label: {
//
//                       HStack{
//                        Image(systemName: "location.north")
//                            .foregroundColor(.white)
//                            .font(.system(size: 24))
//                        Text("Directions")
//                            .foregroundColor(Color(.white))}
//                    })
//                }
//                .padding()
            }
            .padding(.bottom)
           
        }
        .frame(width: UIScreen.main.bounds.width/1.2)
//        .sheet(isPresented: $showDirectionsList, content: {
//            VStack{
//                Text("Directions")
//                          .font(.largeTitle)
//                          .bold()
//                          .padding()
//
//                List(self.route.directions!.sortedArray(using: [NSSortDescriptor(keyPath: \ImageCore.uid, ascending: true)]) as! [Direction], id:\.self){i in
//                    Text(i.directionSentence!)
//            }}
//        })
        .fullScreenCover(isPresented: $showDetailMapView, content: {
            ZStack{
                MapView(polyline: route.polyline)
                    .environmentObject(userData)
                Button {
                    self.showDetailMapView.toggle()
                } label:{
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color(.label).opacity(0.85))
                            .font(.system(size: 32)).padding()
                }.offset(x: -UIScreen.main.bounds.width/2 + 30, y: -UIScreen.main.bounds.height/2 + 60)
                .environmentObject(userData)

            }.ignoresSafeArea(.all)
            .environmentObject(userData)
        })
    }
}


struct NarrowPathInformationView: View {
    var imageName:String
    var text:String
    var data:String
    var body: some View {
        HStack{
            ZStack{
                RoundedRectangle(cornerRadius: 15.0)
                    .fill(Color(.systemGray5))
                    .frame(width: 35, height: 35, alignment: .center)
                    .padding()
                Image(systemName: imageName)
                .font(.system(size: 16, weight: .regular))}
            Text(text)
                .bold()
                .padding(.horizontal)
            Spacer()
            Text(data)
                .padding(.horizontal)
        }
    }
}
