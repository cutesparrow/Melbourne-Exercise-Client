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


class RecentlyRoadSituation: Codable{
    var list:[RoadSituation]
    init(list:[RoadSituation]) {
        self.list = list
    }
}

class RoadSituation: Codable {
    var day: String
    var situation:[OneHourRoadSituation]
    var hours:Int
    init(day:String,situation:[OneHourRoadSituation]) {
        self.day = day
        self.situation = situation
        self.hours = self.situation.count
    }
}

enum WeekDay:String,Codable {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
}
