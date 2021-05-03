//
//  MelbourneRunApp.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 9/3/21.
//
import MapKit
import CoreLocation
import SwiftUI
import CoreData

@main
struct MelbourneRunApp: App {
    @StateObject private var userData = UserData()
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        
        WindowGroup {
            PreLaunch()
//            RoundedGymIconOnMapView()
//            GymNewHomeView()
                .environmentObject(userData)
//            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
 
        
        
        }
    }
   
}
