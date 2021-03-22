//
//  RoadSituationModel.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 22/3/21.
//

import Foundation

struct OneHourRoadSituation: Codable,Hashable{
    var hour:Int
    var high:Int
    var low:Int
    var average:Int
    init(hour:Int,high:Int,low:Int,average:Int) {
        self.hour = hour
        self.average = average
        self.high = high
        self.low = low
    }
}



class RoadSituation: Codable {
    var day: WeekDay
    var situation:[OneHourRoadSituation]
    var hours:Int
    init(day:WeekDay,situation:[OneHourRoadSituation]) {
        self.day = day
        self.situation = situation
        self.hours = self.situation.count
    }
}

enum WeekDay:String,Codable {
    case Mon
    case Tue
    case Wed
    case Thu
    case Fri
    case Sat
    case Sun
}
