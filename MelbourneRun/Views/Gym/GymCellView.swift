//
//  GymCellView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 18/3/21.
//
import Foundation
import SwiftUI

struct GymCellView: View {
    var gym:Gym
    var body: some View {
        HStack(alignment:.center){
            
            ZStack{
                
                VStack{
                    HStack(alignment:.center){
                        Text(gym.name)
                            .foregroundColor(Color(.black).opacity(0.8))
                            .font(.title2)
                            .italic()
                            .bold()
                            
                        Spacer()
                        CircleImageView(imageName: gym.Images[0],size: 80)
                            .font(.system(size: UIScreen.main.bounds.width/9, weight: .regular))
                    }.frame(width: UIScreen.main.bounds.width/1.2)
                    
                    HStack(alignment:.bottom){
                        Text(gym.address)
                            .font(.body)
                            .foregroundColor(Color(.black).opacity(0.6))
                        Spacer()
                        Text("\(gym.distance.description)KM")
                            .foregroundColor(.gray)
                    }
                    .frame(width: UIScreen.main.bounds.width/1.2)
                    .offset(y:-15)
                }
                .padding(10)
                .background(Color.gray.opacity(0.4))
                .cornerRadius(40)
                .foregroundColor(.white)
                .padding(3)
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 3)
                )
                
                
            }
            
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
                             address: "Level 2/341-345 Bourke St, Melbourne VIC 3000")
    static var previews: some View {
        GymCellView(gym: gym)
    }
}
