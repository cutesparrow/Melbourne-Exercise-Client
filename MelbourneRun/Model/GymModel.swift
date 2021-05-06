//
//  GymModel.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 18/3/21.
//

import Foundation
import SwiftUI
import MapKit


struct GymList:Codable{
    var list:[Gym]        
}

struct Gym:Hashable, Codable,Identifiable {
    let id: Int
    let lat: Double
    let long: Double
    let name: String
    let Images: [String]
    let limitation: Int
    let distance: Double
    var star: Bool
    let address: String
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    var classType:String
    var gymTime:GymTime
}

struct GymTime:Hashable,Codable {
    var monday_start:String
    var tuesday_start:String
    var wednesday_start:String
    var thursday_start:String
    var friday_start:String
    var saturday_start:String
    var sunday_start:String
    var monday_close:String
    var tuesday_close:String
    var wednesday_close:String
    var thursday_close:String
    var friday_close:String
    var saturday_close:String
    var sunday_close:String
    
}

struct GymForAnnotation:Hashable, Codable,Identifiable {
    let id: Int16
    let lat: Double
    let long: Double
    let name: String
    var star: Bool
    let address: String
    var classType:String
}
