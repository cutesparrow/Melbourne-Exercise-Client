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
    let gymColor:Color = Color(.systemPink).opacity(0.3)
    let parkColor:Color = Color(.systemGray5).opacity(0.8)
    let playgroundColor:Color = Color(.systemBlue).opacity(0.3)
    let joggingColor:Color = Color(.systemGreen).opacity(0.3)
    let backgroundColor:Color = Color(.systemYellow).opacity(0.07)
    let buttonColor:Color = Color(.systemGray2)
}
