//
//  PopularJoggingRouteModel.swift
//  MelbExercise
//
//  Created by gaoyu shi on 19/4/21.
//
import Foundation

struct PopularJoggingRoute:Identifiable,Codable {
    var id:Int
    var name:String
    var map:String
    var distance:Double
    var longth:Double
    var background:String
    var intruduction:String
    var suburb:String
    var postcode:String
    var latitude:Double
    var longitude:Double
    var detail_text:String
    
}
