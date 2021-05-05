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
//    @Published var locationFetcher = LocationFetcher()
    @Published var showedPermissionAlert:Bool = false
    @Published var showGymUserGuide:Bool = true
    //    @Published var gymList: GymList = GymList(list: [ ])
//    @Published var parkList: ParkList = ParkList(list: [])
//    @Published var playgroundList: PlaygroundList = PlaygroundList(list: [])
//    @Published var joggingPath:[Coordinate] = [Coordinate(latitude: -37.80912284071033, longitude: 144.95963315775296)]
    //    @Published var roadSituation: RecentlyRoadSituation = RecentlyRoadSituation(list:[RoadSituation(day: "monday", situation: [OneHourRoadSituation(hour: 8,high: 17, low: 1, average: 16),OneHourRoadSituation(hour: 9,high: 23, low: 21, average: 22),OneHourRoadSituation(hour: 10,high: 33, low: 26, average: 32),OneHourRoadSituation(hour: 11,high: 47, low: 46, average: 52),OneHourRoadSituation(hour: 12,high: 67, low: 44, average: 52),OneHourRoadSituation(hour: 13,high: 87, low: 76, average: 82),OneHourRoadSituation(hour: 14,high: 67, low: 46, average: 52),OneHourRoadSituation(hour: 15,high: 55, low: 46, average: 52),OneHourRoadSituation(hour: 16,high: 57, low: 51, average: 56),OneHourRoadSituation(hour: 17,high: 23, low: 21, average: 22),OneHourRoadSituation(hour: 18,high: 33, low: 26, average: 32),OneHourRoadSituation(hour: 19,high: 47, low: 46, average: 52),OneHourRoadSituation(hour: 20,high: 67, low: 44, average: 52),OneHourRoadSituation(hour: 21,high: 67, low: 66, average: 66),OneHourRoadSituation(hour: 22,high: 57, low: 56, average: 56),OneHourRoadSituation(hour: 23,high: 55, low: 46, average: 52)]),RoadSituation(day: "monday", situation: [OneHourRoadSituation(hour: 8,high: 17, low: 1, average: 16),OneHourRoadSituation(hour: 9,high: 23, low: 21, average: 22),OneHourRoadSituation(hour: 10,high: 33, low: 26, average: 32),OneHourRoadSituation(hour: 11,high: 47, low: 46, average: 52),OneHourRoadSituation(hour: 12,high: 67, low: 44, average: 52),OneHourRoadSituation(hour: 13,high: 87, low: 76, average: 82),OneHourRoadSituation(hour: 14,high: 67, low: 46, average: 52),OneHourRoadSituation(hour: 15,high: 55, low: 46, average: 52),OneHourRoadSituation(hour: 16,high: 57, low: 51, average: 56),OneHourRoadSituation(hour: 17,high: 23, low: 21, average: 22),OneHourRoadSituation(hour: 18,high: 33, low: 26, average: 32),OneHourRoadSituation(hour: 19,high: 47, low: 46, average: 52),OneHourRoadSituation(hour: 20,high: 67, low: 44, average: 52),OneHourRoadSituation(hour: 21,high: 67, low: 66, average: 66),OneHourRoadSituation(hour: 22,high: 57, low: 56, average: 56),OneHourRoadSituation(hour: 23,high: 55, low: 46, average: 52)])])
//    @Published var image:String = "gym12.jpg"
//    @Published var exerciseTips:String = ""
//    @Published var safeTips:String = ""
   // @Published var selectedGym:Gym = Gym(id: 0, lat: 0, long: 0, name: "", Images: [""], limitation: 0, distance: 0, star: true, address: "",classType: "")
//    @Published var selectedTime:Date = Date()
    @Published var weather:WeatherNow = WeatherNow(location: Position(name: "Melbourne", region: "Victoria", country: "", lat: 1, lon: 1, tz_id: "", localtime_epoch: 1, localtime: ""), current: Weather(temp_c: 12.4, condition: Condition(text: "Clear", icon: "//cdn.weatherapi.com/weather/128x128/day/116.png"),feelslike_c: 12.1))
    @Published var safetyPolicy:[SafetyPolicy] = [SafetyPolicy(id:1,date: "", title: "", content: "")]
//    @Published var locationManager:Bool = LocationManager.shared.permissionIsNotOk
    init() {
        if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
            UserDefaults.standard.set(true, forKey: "didLaunchBefore")
            new = true
        } else {
            new = false
        }
        
        //        if !UserDefaults.standard.bool(forKey: "joggingGuide") {
        //            UserDefaults.standard.set(true, forKey: "didLaunchBefore")
        //            showJoggingGuide = true
        //        } else {
        //            showJoggingGuide = true // set to false after debugging
        //        }
        
        if !UserDefaults.standard.bool(forKey: "showMemberShipSelection"){
            UserDefaults.standard.set(true,forKey: "showMemberShipSelection")
            showMemberShipSelection = true
            UserDefaults.standard.set("No membership",forKey: "membership")
            hasMemberShip = UserDefaults.standard.string(forKey: "membership")!
        } else{
            showMemberShipSelection = false
            hasMemberShip = UserDefaults.standard.string(forKey: "membership") ?? "No membership"
        }
        
    }
//    @Published var showJoggingGuide:Bool = true
//    @Published var showBottomBar:Bool = true
   
    @Published var new:Bool
    @Published var hasMemberShip:String
    @Published var showMemberShipSelection:Bool
    @Published var homepageFistAppear:Bool = true
    @Published var gympageFirstAppear:Bool = true
    @Published var joggingpageFirstAppear:Bool = true
    @Published var showedRangeAlert:Bool = false
    //    @Published var marks:[MarkerLocation] = [
    ////        MarkerLocation( id: 1,lat: -37.81009922787134, long: 144.95898699639088, risk: "high"),
    ////        MarkerLocation( id: 2,lat: -37.812811589000205, long: 144.97426485764535, risk: "low")
    //    ]
    //    @Published var showInformation:ShowInformation = ShowInformation(imageName: "", safetyTips: "", exerciseTips: "", exerciseBenefits: "")
    //@Published var cards:Cards = Cards(customizedCards: [CustomizedCard(id: 0, path: [Coordinate(latitude: -37.81228028830977, longitude: 144.96229225616813),Coordinate(latitude: -37.816196112093316, longitude: 144.96404105636753),Coordinate(latitude: -37.81470439418989, longitude: 144.96899777840505)], distance: 10.2, risk: "Low", time: "35 Mins"),CustomizedCard(id: 1, path: [Coordinate(latitude: -37.81228028830977, longitude: 144.96229225616813),Coordinate(latitude: -37.816196112093316, longitude: 144.96404105636753),Coordinate(latitude: -37.81470439418989, longitude: 144.96899777840505)], distance: 8.2, risk: "High", time: "25 Mins")], popularCards: [PopularCard(id: 0, path: [Coordinate(latitude: -37.81228028830977, longitude: 144.96229225616813),Coordinate(latitude: -37.816196112093316, longitude: 144.96404105636753),Coordinate(latitude: -37.81470439418989, longitude: 144.96899777840505)], distance: 10.2, risk: "Medium", time: "20 Mins", popularStar: 4, distanceToUser: 3.1),PopularCard(id: 1, path: [Coordinate(latitude: -37.81228028830977, longitude: 144.96229225616813),Coordinate(latitude: -37.816196112093316, longitude: 144.96404105636753),Coordinate(latitude: -37.81470439418989, longitude: 144.96899777840505)], distance: 10.2, risk: "High", time: "30 Mins", popularStar: 5, distanceToUser: 1.1)])
//    @Published var popularCards:[PopularCard] = [PopularCard(id: 0, path: [Coordinate(latitude: -37.81030265856694, longitude:  144.961304425536)], distance: 0, risk: "", time: "", popularStar: 0, distanceToUser: 0)]
//    @Published var customizedCards:[CustomizedCard] = [CustomizedCard(id: 0, path: [Coordinate(latitude: -37.81030265856694, longitude:  144.961304425536)], distance: 0, risk: "", time: "", directions: [""])]
    //        [CustomizedCard(id: 0, path: [Coordinate(latitude: -37.81228028830977, longitude: 144.96229225616813),Coordinate(latitude: -37.816196112093316, longitude: 144.96404105636753),Coordinate(latitude: -37.81470439418989, longitude: 144.96899777840505)], distance: 10.2, risk: "Low", time: "35 Mins"),CustomizedCard(id: 1, path: [Coordinate(latitude: -37.81228028830977, longitude: 144.96229225616813),Coordinate(latitude: -37.816196112093316, longitude: 144.96404105636753),Coordinate(latitude: -37.81470439418989, longitude: 144.96899777840505)], distance: 8.2, risk: "High", time: "25 Mins")]
}

struct weather:Codable {
    var currentTemperature: Float
    var dailyMaxTemperature: Float
    var dailyMinTemperature: Float
    var averageTemperature: String
    var currentConditionsText: String
}


func checkUserLocation(lat:Double,long:Double) -> Bool{
    if (-37.821088204348065 <= lat && lat <= -37.80128789662342) && (144.93188435005916 <= long && long <= 144.9741130468984){
        return true
    }
    else{
        return false
    }
}
//-37.80128789662342, 144.9741130468984
//-37.821088204348065, 144.93188435005916
struct MarkerLocation:Codable {
    var id : Int
    var lat: Double
    var long: Double
    var risk: String
}

extension MarkerLocation: Identifiable { }

extension MarkerLocation {
    static func getLocation() -> [MarkerLocation] {
        return [
            MarkerLocation( id: 1,lat: -37.81009922787134, long: 144.95898699639088, risk: "high"),
            MarkerLocation( id: 2,lat: -37.812811589000205, long: 144.97426485764535, risk: "low")
        ]
    }
}
