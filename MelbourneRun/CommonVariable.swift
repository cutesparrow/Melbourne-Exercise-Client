//
//  CommonVariable.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 10/3/21.
//

import Foundation
import SwiftUI


struct AppColor {
    public static let shared = AppColor()
    let gymColor:Color = .pink
    let outDoorColor:Color = .orange
    let parkColor:Color = Color(.systemGray5)
    let playgroundColor:Color = Color(.systemBlue)
    let joggingColor:Color = .blue
    let backgroundColor:Color = Color(.systemYellow)
    let buttonColor:Color = Color(.systemGray2)
    let trendGraphColor:Color = Color(.gray)
    let highRiskColor:Color = Color.red
    let midRiskColor:Color = Color.orange
    let lowRiskColor:Color = Color.yellow
    let noRiskColor:Color = Color.green
    let homeColor:Color = .purple

}


struct StandardRiskAssessment{
    public static let shared = StandardRiskAssessment()
    func getRiskLevel(average:Int) -> RiskLevel{
        switch average {
        case 0..<30:
            return .no
        case 30..<50:
            return .low
        case 50..<70:
            return .mid
        case 70...:
            return .high
        default:
            return .low
        }
    }
}

enum RiskLevel{
    case no,low,mid,high
}
