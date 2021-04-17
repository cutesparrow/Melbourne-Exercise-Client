//
//  JoggingPathCardModel.swift
//  MelbExercise
//
//  Created by gaoyu shi on 8/4/21.
//

import Foundation

struct CustomizedCard:Codable,Identifiable{
    var id:Int
    var image:String
    var distance:Double
    var risk:String
    var time:String
    var instructions:[String]
}

struct PopularCard:Codable,Identifiable{
    var id:Int
    var path:[Coordinate]
    var distance:Double
    var risk:String
    var time:String
    var popularStar:Int
    var distanceToUser:Double
}


struct Cards:Codable {
    var customizedCards:[CustomizedCard]
    var popularCards:[PopularCard]
}
