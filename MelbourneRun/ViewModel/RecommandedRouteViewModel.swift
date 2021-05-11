//
//  RecommandedRouteViewModel.swift
//  MelbExercise
//
//  Created by gaoyu shi on 9/5/21.
//

import Foundation
import MapKit
import CoreData

class RecommandedRouteViewModel:ObservableObject {
    @Published var walkingRoutes:[WalkingRouteCard] = []
    @Published var cyclingRoutes:[WalkingRouteCard] = []
    @Published var successWalking:Bool = false
    @Published var successCycling:Bool = false
    @Published var error:Bool = false
    @Published var loading:Bool = false
    @Published var showSheet:Bool = false
    
    func loadRecommandedRoutes(location:CLLocationCoordinate2D,length:Double,type:String,context:NSManagedObjectContext){
        let completion: (Result<[WalkingRouteCard], Error>) -> Void = { result in
            switch result {
            case let .success(list):
                if list.count != 0{
                    if type == "bike2"{
                        self.cyclingRoutes = list
                        self.templeteSaveCycling(context: context)
                        self.loading = false
//                        self.successCycling = true
                    } else if type == "foot"{
                        self.walkingRoutes = list
                        self.templeteSaveWalking(context: context)
                        self.loading = false
//                        self.successWalking = true
                    } else {
                        print("type error")
                        self.loading = false
                        self.error = true
                    }
            }
                else{
                    self.loading = false
                    self.error = true
                }
            case let .failure(error):
                print(error)
                self.loading = false
                self.error = true
            }
        }
        self.loading = true
        delete(context:context)
        _ = NetworkAPI.loadCustomizedCards(location: location, length: length,type:type, completion: completion)
    }
    
    func templeteSaveWalking(context:NSManagedObjectContext){
        self.walkingRoutes.forEach { data in
            let entity = WalkingCore(context:context)
            entity.uid = Int16(data.id)
            entity.length = data.distance
            entity.risk = data.risk
            entity.time = data.time
            entity.mapImage = data.image
            entity.polyline = data.polyline
            entity.type = "Walking & Dog"
            entity.like = false
        }
        do {
            try context.save()
//            self.success = true
            self.successWalking = true
            self.showSheet = true
        } catch  {
            self.error = true
        }
    }
    
    func templeteSaveCycling(context:NSManagedObjectContext){
        self.cyclingRoutes.forEach { data in
            let entity = CyclingCore(context:context)
            entity.uid = Int16(data.id)
            entity.length = data.distance
            entity.risk = data.risk
            entity.time = data.time
            entity.mapImage = data.image
            entity.polyline = data.polyline
            entity.type = "Cycling"
            entity.like = false
        }
        do {
            try context.save()
//            self.success = true
            self.successCycling = true
            self.showSheet = true
        } catch  {
            self.error = true
        }
    }
    
    func delete(context:NSManagedObjectContext){
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "WalkingCore")
        let fetchRequest2: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CyclingCore")
        let deleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        let deleteRequest2 = NSBatchDeleteRequest(fetchRequest: fetchRequest2)
        do {
            try context.execute(deleteRequest1)
        } catch let error as NSError {
            print("\(error)")
        }
        do {
            try context.execute(deleteRequest2)
        } catch let error as NSError {
            print("\(error)")
        }
        print("success delete")
    }
    
    
}
