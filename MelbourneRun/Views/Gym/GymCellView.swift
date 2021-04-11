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
    var gym:Gym
    var body: some View {
        HStack(alignment:.center){
            ZStack{
                WebImage(url: URL(string: NetworkManager.shared.urlBasePath + gym.Images[0] + ".jpg"))
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .frame(width: UIScreen.main.bounds.width/1.3+19,height: 99, alignment: .center)
                    
                VisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .frame(width: UIScreen.main.bounds.width/1.3+20,height: 100, alignment: .center)
                    .padding(0)
                    
                HStack{
                    VStack(alignment:.leading){
                        Text(gym.name)
                            .foregroundColor(Color(.label))
                            .font(.body)
                            
                            .bold()
                            .lineLimit(1)
                        Text("\(gym.distance.description)KM")
                            .foregroundColor(Color(.label))
                            .font(.caption)
                            .lineLimit(1)
                            
                        Text(gym.address)
                            .foregroundColor(Color(.label))
                            .font(.caption)
                            .lineLimit(1)
                    }
                    Spacer()
                    CircleImageView(imageName: gym.Images[0],size: 80)
                        .font(.system(size: UIScreen.main.bounds.width/9, weight: .regular))
                }
                .frame(width: UIScreen.main.bounds.width/1.3,height: 80, alignment: .center)
                
            }
            
//            .padding(10)
//            .cornerRadius(25)
//            .foregroundColor(.white)
//            .padding(3)
        }
    }
}

struct GymCellView_Previews: PreviewProvider {
    static var gym:Gym = Gym(id: 1,
                             lat: -37.81182294764945,
                             long: 144.96396366254962,
                             name: "Fitness First Bourke St",
                             Images: ["gym1","gym2","gym3"],
                             limitation: 21, distance: 3.23,
                             star: false,
                             address: "Level 2/341-345 Bourke St, Melbourne VIC 3000",classType: "")
    static var previews: some View {
        GymCellView(gym: gym)
    }
}
