//
//  CyclePathView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 19/4/21.
//

import SwiftUI

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
import CoreData
import AlertToast

struct CyclePathView: View {
    @EnvironmentObject var userData:UserData
    @State var selectedTab:Int = 0
    @Binding var show:Bool
//    @State var showDirectionsList:Bool = false
    @Environment(\.managedObjectContext) var context
    @State var success:Bool = false
    @State var error:Bool = false
    @State var showDetailMapView:Bool = false
    @FetchRequest(entity: CyclingCore.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \CyclingCore.uid, ascending: true)]) var result: FetchedResults<CyclingCore>
    @FetchRequest(entity: RouteCore.entity(), sortDescriptors: []) var favoriteRoute: FetchedResults<RouteCore>
    private func saveThisRoute(card:CyclingCore){
        if result[selectedTab].like == false{
            let entity = RouteCore(context:context)
        entity.length = result[selectedTab].length
        entity.time = result[selectedTab].time
        entity.risk = result[selectedTab].risk
        entity.mapImage = result[selectedTab].mapImage
        entity.type = "Cycling"
        entity.showName = ""
        entity.polyline = result[selectedTab].polyline
        entity.addedTime = Date()
        result[selectedTab].like.toggle()
        do {
            try context.save()
            self.success = true
            print("success")
        } catch {
            print(error.localizedDescription)
            self.error = true
        }
        } else {
            
            print(result[selectedTab].mapImage)
            favoriteRoute.forEach { route in
                if route.mapImage == result[selectedTab].mapImage{
                    context.delete(route)
                    print("delete")
                }
            }
            result[selectedTab].like.toggle()
            do {
                try context.save()
                self.success = true
                print("success delete")
            } catch {
                print(error.localizedDescription)
                self.error = true
            }
        }
    }
    var body: some View {
        VStack{
            Spacer()
            HStack{
                VStack(alignment: .leading){
                    Text("Discover Your Cycling")
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .foregroundColor(.gray)
                    Text("Routes").font(.system(size: 40, weight: .bold, design: .default)).foregroundColor(Color(.label))
                }
                Spacer()
                
            }.padding(.leading).padding(.top).padding(.trailing)
            .padding(.bottom,-20)
            Spacer(minLength: 0)
            TabView(selection: $selectedTab) {
                ForEach(self.result,id:\.uid) { card in
//                    DirectionMapView(directions: $directionsList, coordinatesList: card.path)
                    ZStack{
                        WebImage(url: URL(string: NetworkManager.shared.urlBasePath + card.mapImage))
                        .placeholder{
                            Color.gray
                        }
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width/1.2,height:UIScreen.main.bounds.width/1.8)
                        .clipped()
                        .cornerRadius(14)
//
                        .shadow(radius: 4)
                        
                        Button(action: {saveThisRoute(card: card)}) {
                            Image(systemName: card.like ? "heart.fill" : "heart")
                                .foregroundColor(AppColor.shared.gymColor)
                                .font(.title)
                                .shadow(radius: 6)
                        }.offset(x:UIScreen.main.bounds.width/2.4 - 25,y:-UIScreen.main.bounds.width/3.6 + 25)
                    }.tag(Int(card.uid))
                        
                }
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .frame(height: 340)
            .offset(y:-20)
            
            PathInformationView(imageName: "timer", text: "Time", data: result[selectedTab].time)
                .padding(.vertical,-15)
            PathInformationView(imageName: "playpause", text: "Length", data: String(result[selectedTab].length)+" KM")
                .padding(.vertical,-15)
            Spacer(minLength: 0)
            HStack{
                Spacer(minLength: 0)
                    Button(action: {
                        withAnimation {
                            show = false
                        }
                    }, label: {
                        
                        HStack{
                            Image(systemName: "pip.exit")
                                .font(.system(size: 16,weight: .regular))
                                .foregroundColor(Color(.white))
                            Text("Close")
                                .foregroundColor(Color(.white))
                        }.padding(.horizontal)
                        .padding(.vertical,5)
                        
                    }).background(Capsule().fill(Color(.systemGray3)))
                    .frame(width:UIScreen.main.bounds.width/2.5)
                    
                
                Spacer(minLength: 0)
                    Button(action: {
//                        fetchDirection()
//                        fetchDirection2()
                        self.showDetailMapView = true
                    }, label: {
                        
                        HStack{
                            Image(systemName: "arrow.triangle.turn.up.right.diamond.fill")
                                .font(.system(size: 16,weight: .regular))
                                .foregroundColor(Color(.white))
                            Text("Show Map")
                                .foregroundColor(Color(.white))
                        }.padding(.horizontal)
                        .padding(.vertical,5)
                        
                    }).background(Capsule().fill(Color.blue))
                    .frame(width:UIScreen.main.bounds.width/2.5)
                Spacer(minLength: 0)
            }
            
           
        }
        .toast(isPresenting: $error, duration: 1.2, tapToDismiss: true, alert: { AlertToast(type: .error(.red), title: "Failure", subTitle: "")
        }, completion: {_ in
            self.error = false
        })
        .toast(isPresenting: $success, duration: 1.2, tapToDismiss: true, alert: { AlertToast(type: .complete(Color.green), title: "Saved", subTitle: "")
        }, completion: {_ in
            self.success = false
        })
//        .sheet(isPresented: $showDirectionsList, content: {
//            VStack{
//                Text("Directions")
//                          .font(.largeTitle)
//                          .bold()
//                          .padding()
//
//                List(result[selectedTab].instructions, id:\.self){i in
//                    Text(i)
//
//            }}
//        })
        .fullScreenCover(isPresented: $showDetailMapView, content: {
            ZStack{
                MapView(polyline: result[selectedTab].polyline)
                    .environmentObject(userData)
                Button {
                    self.showDetailMapView = false
                        
                } label:{
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color(.label).opacity(0.85))
                            .font(.system(size: 32)).padding()
                }.offset(x: -UIScreen.main.bounds.width/2 + 30, y: -UIScreen.main.bounds.height/2 + 60)
                .environmentObject(userData)

            }.ignoresSafeArea(.all)
            .environmentObject(userData)
        })
//        .onAppear(perform: {
//
//        })
    }
}


