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
    @Published var roadSituation: RoadSituation = RoadSituation(day: WeekDay.Mon, situation: [OneHourRoadSituation(hour: 8,high: 17, low: 1, average: 16),OneHourRoadSituation(hour: 9,high: 23, low: 21, average: 22),OneHourRoadSituation(hour: 10,high: 33, low: 26, average: 32),OneHourRoadSituation(hour: 11,high: 47, low: 46, average: 52),OneHourRoadSituation(hour: 12,high: 67, low: 44, average: 52),OneHourRoadSituation(hour: 13,high: 87, low: 76, average: 82),OneHourRoadSituation(hour: 14,high: 67, low: 46, average: 52),OneHourRoadSituation(hour: 15,high: 55, low: 46, average: 52),OneHourRoadSituation(hour: 16,high: 57, low: 51, average: 56),OneHourRoadSituation(hour: 17,high: 23, low: 21, average: 22),OneHourRoadSituation(hour: 18,high: 33, low: 26, average: 32),OneHourRoadSituation(hour: 19,high: 47, low: 46, average: 52),OneHourRoadSituation(hour: 20,high: 67, low: 44, average: 52),OneHourRoadSituation(hour: 21,high: 67, low: 66, average: 66),OneHourRoadSituation(hour: 22,high: 57, low: 56, average: 56),OneHourRoadSituation(hour: 23,high: 55, low: 46, average: 52)])
    @Published var image:String = "gym12.jpg"
    @Published var slogan:String = ""
    @Published var safeTips:String = ""
}
