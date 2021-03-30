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
        case 0..<5*3:
            return .no
        case 5..<35*3:
            return .low
        case 35..<160*3:
            return .mid
        case (160*3)...:
            return .high
        default:
            return .low
        }
    }
}

enum RiskLevel{
    case no,low,mid,high
}
