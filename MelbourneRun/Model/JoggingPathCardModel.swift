//
//  JoggingPathCardModel.swift
//  MelbExercise
//
//  Created by gaoyu shi on 8/4/21.
//

import Foundation

struct WalkingRouteCard:Codable,Identifiable{
    var id:Int
    var image:String
    var distance:Double
    var risk:String
    var time:String
    var instructions:[String]
    var polyline:String
}

struct CyclingCard:Codable,Identifiable{
    var id:Int
    var path:[Coordinate]
    var distance:Double
    var risk:String
    var time:String
    var popularStar:Int
    var distanceToUser:Double
    var polyline:String
}


struct Cards:Codable {
    var customizedCards:[WalkingRouteCard]
    var popularCards:[CyclingCard]
}
