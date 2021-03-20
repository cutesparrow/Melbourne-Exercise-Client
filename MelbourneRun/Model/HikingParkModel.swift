//
//  HikingParkModel.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 18/3/21.
//


import Foundation
import SwiftUI


struct ParkList:Codable{
    var list:[Park]
}

struct Park:Codable,Identifiable {
    let id: Int
    let lat: Double
    let long: Double
    let name: String
    let Images: [String]
    let limitation: Int
    let distance: Double
    let star: Bool
}

