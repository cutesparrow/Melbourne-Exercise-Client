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

struct CustomizePathView: View {
    @EnvironmentObject var userData:UserData
    @State var selectedTab:Int = 0
    @State var showDirectionsList:Bool = false
    @State var customizedCards:[CustomizedCard]
    @Environment(\.managedObjectContext) var context
    @State var success:Bool = false
    @State var error:Bool = false
    private func saveThisRoute(){
        let entity = RouteCore(context:context)
        entity.length = self.customizedCards[selectedTab].distance
        entity.time = self.customizedCards[selectedTab].time
        entity.risk = self.customizedCards[selectedTab].risk
        entity.mapImage = self.customizedCards[selectedTab].image
        entity.type = "Walking & Dog"
        self.customizedCards[selectedTab].instructions.forEach { direction in
            let directionData = Direction(context:context)
            directionData.uid = Int16(self.customizedCards[selectedTab].instructions.firstIndex(where: { $0 == direction })!)
            directionData.directionSentence = direction
            entity.addToDirections(directionData)
        }
        do {
            try context.save()
            self.success = true
            print("success")
        } catch {
            print(error.localizedDescription)
            self.error = true
        }
    }
    var body: some View {
        VStack{
            Spacer()
            HStack{
                VStack(alignment: .leading){
                    Text("Discover Your Walking")
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .foregroundColor(.gray)
                    Text("Routes").font(.system(size: 40, weight: .bold, design: .default)).foregroundColor(Color(.label))
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
                ZStack{
                    RoundedRectangle(cornerRadius: 15.0)
                        .fill(Color(.systemGray4))
                        .frame(width: 130, height: 50, alignment: .center)
                        .padding()
                    Button(action: saveThisRoute, label: {
                        
                       HStack{
                        Image(systemName: "heart.fill")
                            .foregroundColor(AppColor.shared.gymColor)
                            .font(.system(size: 24))
                        Text("Favorites")
                            .foregroundColor(Color(.white))}
                        
                    })
                    
                }
                
            }
            .padding(.vertical,-15)
           
        }
        .toast(isPresenting: $error, duration: 1.2, tapToDismiss: true, alert: { AlertToast(type: .error(.red), title: "Failure", subTitle: "")
        }, completion: {_ in
            self.error = false
        })
        .toast(isPresenting: $success, duration: 1.2, tapToDismiss: true, alert: { AlertToast(type: .complete(Color.green), title: "Saved", subTitle: "")
        }, completion: {_ in
            self.success = false
        })
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

