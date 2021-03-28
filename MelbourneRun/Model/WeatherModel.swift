//
//  WeatherModel.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 28/3/21.
//

import Foundation

struct WeatherNow:Codable {
    var location:Position
    var current:Weather
}

struct Position:Codable {
    var name:String
    var region:String
    var country:String
    var lat:Float
    var lon:Float
    var tz_id:String
    var localtime_epoch:Int64
    var localtime:String
}


struct Weather:Codable {
    var temp_c:Double
    var text:String
    var feelslike_c:Double
    var icon:String
}
