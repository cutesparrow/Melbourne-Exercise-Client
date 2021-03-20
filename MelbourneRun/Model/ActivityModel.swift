//
//  ActivityModel.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 14/3/21.
//

import Foundation
import SwiftUI


struct ActivityList{
    var list:[Activity]
}

struct Activity {
    
    let name:String
    let RoundedRectangleColor:Color
    let textColor:Color
    let logo:CircleImageView
}



var hiking = Activity(name: "Hiking",  RoundedRectangleColor: AppColor.shared.parkColor, textColor: .black, logo: CircleImageView(imageName: "hiking",size: 100.0))
var gym = Activity(name: "Gym",  RoundedRectangleColor: AppColor.shared.gymColor, textColor: .black, logo: CircleImageView(imageName: "gym",size: 100.0))
var walkDog = Activity(name: "WalkDog",  RoundedRectangleColor: AppColor.shared.playgroundColor, textColor: .black, logo: CircleImageView(imageName: "dog",size: 100.0))
var jogging = Activity(name: "Jogging",  RoundedRectangleColor: AppColor.shared.joggingColor, textColor: .black, logo: CircleImageView(imageName: "jogging",size: 100.0))
var activities:ActivityList = ActivityList(list: [hiking,gym,walkDog,jogging])

