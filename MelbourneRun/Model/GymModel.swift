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
}

