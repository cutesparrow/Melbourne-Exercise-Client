//
//  RouteResponseModel.swift
//  MelbExercise
//
//  Created by gaoyu shi on 8/5/21.
//

import Foundation

struct RouteResponseCus:Codable {
    var routes:[RouteCus]
    var waypoints:[WaypointCus]
    var code:String
    var uuid:String
}

struct WaypointCus:Codable {
    var name:String
    var location:[Double]
}

struct RouteCus:Codable {
    var distance:Double
    var duration:Double
    var geometry:String
    var weight:Double
    var weight_name:String
    var legs:[LegCus]
    var routeOptions:RouteOptionsCus
//    var voiceLocale:String
}

struct LegCus:Codable{
    var distance:Double
    var duration:Double
    var summary:String
    var steps:[StepCus]
    var admins:AdminCus
    var weight:Double
}
struct AdminCus:Codable {
    var iso_3166_1_alpha3:String
    var iso_3166_1:String
}

struct RouteOptionsCus:Codable {
    var baseUrl:String
    var user:String
    var profile:String
    var coordinates:[[Double]]
    var language:String
    var bearings:String
    var continueStraight:Bool
    var roundaboutExits:Bool
    var geometries:String
    var overview:String
    var steps:Bool
    var annotations:String
    var voiceInstructions:Bool
    var bannerInstructions:Bool
    var voiceUnits:String
    var accessToken:String
    var requestUuid:String
}


struct StepCus:Codable {
    var name:String
    var duration:Double
    var weight:Double
    var distance:Double
    var geometry:String
    var driving_side:String
    var mode:String
    var maneuver:ManeuverCus
    var intersections:[IntersectionsCus]
    var voiceInstructions:[VoiceInstructionsCus]
    var bannerInstructions:[BannerInstructionsCus]
}


struct ManeuverCus:Codable {
    var bearing_before:Int
    var bearing_after:Int
    var location:[Double]
    var modifier:String
    var type:String
    var instruction:String
    
}

struct IntersectionsCus:Codable {
    var out:Int
    var entry:[Bool]
    var bearings:[Int]
    var location:[Double]
}
struct VoiceInstructionsCus:Codable {
    var distanceAlongGeometry:Int
    var announcement:String
    var ssmlAnnouncement:String
    
}
struct BannerInstructionsCus:Codable {
    var distanceAlongGeometry:Double
    var primary:PrimaryCus
    var sub:SubCus
}

struct SubCus:Codable {
    var components:ComponentsCus
    var type:String
    var modifier:String
    var text:String
}

struct PrimaryCus:Codable {
    var text:String
    var type:String
    var modifier:String
    var components:[ComponentsCus]
//    var secondary: String?
}

struct ComponentsCus:Codable {
    var text:String
    var type:String
}
