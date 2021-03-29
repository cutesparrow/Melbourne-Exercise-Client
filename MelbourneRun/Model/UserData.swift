//
//  UserData.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 18/3/21.
//


import Foundation
import Combine
import MapKit


class UserData: ObservableObject {
    @Published var locationFetcher = LocationFetcher()
    @Published var gymList: GymList = GymList(list: [ ])
    @Published var parkList: ParkList = ParkList(list: [])
    @Published var playgroundList: PlaygroundList = PlaygroundList(list: [])
    @Published var joggingPath:[Coordinate] = [Coordinate(latitude: -37.80912284071033, longitude: 144.95963315775296)]
    @Published var roadSituation: RecentlyRoadSituation = RecentlyRoadSituation(list:[RoadSituation(day: "monday", situation: [OneHourRoadSituation(hour: 8,high: 17, low: 1, average: 16),OneHourRoadSituation(hour: 9,high: 23, low: 21, average: 22),OneHourRoadSituation(hour: 10,high: 33, low: 26, average: 32),OneHourRoadSituation(hour: 11,high: 47, low: 46, average: 52),OneHourRoadSituation(hour: 12,high: 67, low: 44, average: 52),OneHourRoadSituation(hour: 13,high: 87, low: 76, average: 82),OneHourRoadSituation(hour: 14,high: 67, low: 46, average: 52),OneHourRoadSituation(hour: 15,high: 55, low: 46, average: 52),OneHourRoadSituation(hour: 16,high: 57, low: 51, average: 56),OneHourRoadSituation(hour: 17,high: 23, low: 21, average: 22),OneHourRoadSituation(hour: 18,high: 33, low: 26, average: 32),OneHourRoadSituation(hour: 19,high: 47, low: 46, average: 52),OneHourRoadSituation(hour: 20,high: 67, low: 44, average: 52),OneHourRoadSituation(hour: 21,high: 67, low: 66, average: 66),OneHourRoadSituation(hour: 22,high: 57, low: 56, average: 56),OneHourRoadSituation(hour: 23,high: 55, low: 46, average: 52)]),RoadSituation(day: "monday", situation: [OneHourRoadSituation(hour: 8,high: 17, low: 1, average: 16),OneHourRoadSituation(hour: 9,high: 23, low: 21, average: 22),OneHourRoadSituation(hour: 10,high: 33, low: 26, average: 32),OneHourRoadSituation(hour: 11,high: 47, low: 46, average: 52),OneHourRoadSituation(hour: 12,high: 67, low: 44, average: 52),OneHourRoadSituation(hour: 13,high: 87, low: 76, average: 82),OneHourRoadSituation(hour: 14,high: 67, low: 46, average: 52),OneHourRoadSituation(hour: 15,high: 55, low: 46, average: 52),OneHourRoadSituation(hour: 16,high: 57, low: 51, average: 56),OneHourRoadSituation(hour: 17,high: 23, low: 21, average: 22),OneHourRoadSituation(hour: 18,high: 33, low: 26, average: 32),OneHourRoadSituation(hour: 19,high: 47, low: 46, average: 52),OneHourRoadSituation(hour: 20,high: 67, low: 44, average: 52),OneHourRoadSituation(hour: 21,high: 67, low: 66, average: 66),OneHourRoadSituation(hour: 22,high: 57, low: 56, average: 56),OneHourRoadSituation(hour: 23,high: 55, low: 46, average: 52)])])
    @Published var image:String = "gym12.jpg"
    @Published var exerciseTips:String = ""
    @Published var safeTips:String = ""
    @Published var selectedGym:Gym = Gym(id: 0, lat: 0, long: 0, name: "", Images: [""], limitation: 0, distance: 0, star: true, address: "")
    @Published var selectedTime:Date = Date()
    @Published var weather:WeatherNow = WeatherNow(location: Position(name: "Melbourne", region: "Victoria", country: "", lat: 1, lon: 1, tz_id: "", localtime_epoch: 1, localtime: ""), current: Weather(temp_c: 12.4, condition: Condition(text: "Clear", icon: "//cdn.weatherapi.com/weather/128x128/day/116.png"),feelslike_c: 12.1))
    @Published var safetyPolicy:[SafetyPolicy] = [SafetyPolicy(id:1,date: "", title: "", content: "")]
}

struct weather:Codable {
    var currentTemperature: Float
    var dailyMaxTemperature: Float
    var dailyMinTemperature: Float
    var averageTemperature: String
    var currentConditionsText: String
}
