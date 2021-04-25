//
//  GymCellView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 18/3/21.
//
import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct GymCellView: View {
    @ObservedObject var gym:GymCore
    @Environment(\.managedObjectContext) var context
    var body: some View {
        
        HStack{
            
            NavigationLink(destination: GymRecordView(fetchedGym:gym)) {
                WebImage(url: URL(string: NetworkManager.shared.urlBasePath + (gym.images?.allObjects as! [ImageCore])[0].name + ".jpg"))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(15)
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    Text(gym.name)
                        .foregroundColor(Color(.label))
                        .fontWeight(.bold)
                    
                    Text("\(gym.distance.description)KM")
                        .foregroundColor(Color(.label))
                }
                .padding(.leading,10)
            }
            
            Spacer(minLength: 0)
            Button(action: {
                context.performAndWait {
                    gym.star.toggle()
                    try? context.save()
                }
                if gym.star{
                    print("liked")
                } else{
                    print("disliked")
                }
                
            }) {
                Image(systemName: gym.star ? "star.fill" : "star")
                    .foregroundColor(.yellow)
                    .font(.title)
            }
        }
        .background(Color(.systemBackground).shadow(color: Color.black.opacity(0.12), radius: 5, x: 0, y: 4))
        .cornerRadius(15)
//            HStack(alignment:.center){
//            ZStack{
//                WebImage(url: URL(string: NetworkManager.shared.urlBasePath + (gym.images?.allObjects as! [ImageCore])[0].name + ".jpg"))
//                    .resizable()
//                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
//                    .frame(width: UIScreen.main.bounds.width/1.2+19,height: 99, alignment: .center)
//
//                VisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
//                    .clipShape(RoundedRectangle(cornerRadius: 25))
//                    .frame(width: UIScreen.main.bounds.width/1.2+20,height: 100, alignment: .center)
//                    .padding(0)
//
//                HStack{
//
//                    CircleImageView(imageName: (gym.images?.allObjects as! [ImageCore])[0].name,size: 80)
//                        .font(.system(size: UIScreen.main.bounds.width/9, weight: .regular))
//
//                    VStack(alignment:.leading){
//                        Text(gym.name)
//                            .foregroundColor(Color(.label))
//                            .font(.body)
//                            .bold()
//                            .lineLimit(1)
//                        Text("\(gym.distance.description)KM")
//                            .foregroundColor(Color(.label))
//                            .font(.caption)
//                            .lineLimit(1)
//
////                        Text(gym.address)
////                            .foregroundColor(Color(.label))
////                            .font(.caption)
////                            .lineLimit(1)
//                    }
//                    Spacer()
//                    Button(action: {gym.star.toggle()}) {
//                        Image(systemName: gym.star ? "star.fill" : "star")
//                            .foregroundColor(.yellow)
//                            .font(.title)
//                    }
//
//                }
//                .frame(width: UIScreen.main.bounds.width/1.2,height: 80, alignment: .center)
//
//            }
//
//
////            .padding(10)
////            .cornerRadius(25)
////            .foregroundColor(.white)
////            .padding(3)
//        }
            
        
    }
}


