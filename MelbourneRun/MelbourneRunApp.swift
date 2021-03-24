//
//  MelbourneRunApp.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 9/3/21.
//
import MapKit
import CoreLocation
import SwiftUI

@main
struct MelbourneRunApp: App {
    @StateObject private var userData = UserData()
    
    var body: some Scene {
        
        WindowGroup {
            PreLaunch()
                .environmentObject(userData)
        
        
        }
    }
   
}
