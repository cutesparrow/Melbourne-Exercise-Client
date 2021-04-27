//
//  PopularRouteViewModel.swift
//  MelbExercise
//
//  Created by gaoyu shi on 27/4/21.
//

import Foundation
import CoreData
import SwiftUI

class PopularRouteViewModel:ObservableObject{
    @Published var popularRoutes:[PopularJoggingRoute] = []
    @Published var loading:Bool = false
    @Published var error:Bool = false
    @Published var success:Bool = false
    
    func loadPopularCardsData(location:CLLocationCoordinate2D,context:NSManagedObjectContext){
        let completion: (Result<[PopularJoggingRoute], Error>) -> Void = { result in
            switch result {
            case let .success(list):
                self.popularRoutes = list
                self.saveData(context: context)
                self.loading = false
                self.success = true
            case let .failure(error): print(error)
                self.loading = false
                self.error = true
            }
            
        }
        self.loading = true
        _ = NetworkAPI.loadPopularCards(location: location, completion: completion)
    }
    
    func saveData(context:NSManagedObjectContext){
        self.popularRoutes.forEach { (data) in
            let entity = PopularRouteCore(context: context)
            entity.name = data.name
            entity.uid = Int16(data.id)
            entity.map = data.map
            entity.distance = data.distance
            entity.distance = data.distance
            entity.length = data.longth
            entity.background = data.background
            entity.intruduction = data.intruduction
            entity.suburb = data.suburb
            entity.postcode = data.postcode
            entity.latitude = data.latitude
            entity.longitude = data.longitude
            entity.detail_text = data.detail_text
            entity.safety_tips = data.safety_tips
            entity.star = false
        }
        do {
            try context.save()
            self.success = true
            print("success")
        } catch  {
            print(error.localizedDescription)
            self.error = true
        }
        
    }
    
    func reloadPopularCardsData(location:CLLocationCoordinate2D,context:NSManagedObjectContext){
        let completion: (Result<[PopularJoggingRoute], Error>) -> Void = { result in
            switch result {
            case let .success(list):
                self.popularRoutes = list
                self.refreshData(context: context)
                self.loading = false
                self.success = true
            case let .failure(error): print(error)
                self.loading = false
                self.error = true
            }
            
        }
        self.loading = true
        _ = NetworkAPI.loadPopularCards(location: location, completion: completion)
    }
    
    func refreshData(context:NSManagedObjectContext){
        let fetchRequest : NSFetchRequest<PopularRouteCore> = PopularRouteCore.fetchRequest()
        let idDescriptor = NSSortDescriptor(key: "uid", ascending: true)
        fetchRequest.sortDescriptors = [idDescriptor]
        
        do {
            let result = try context.fetch(fetchRequest) as [PopularRouteCore]
            self.popularRoutes.forEach { (data) in
                var found = false
                result.forEach { (popularRouteCore) in
                    if data.id == popularRouteCore.uid{
                        found = true
                        context.performAndWait {
                            popularRouteCore.name = data.name
                            popularRouteCore.uid = Int16(data.id)
                            popularRouteCore.map = data.map
                            popularRouteCore.distance = data.distance
                            popularRouteCore.distance = data.distance
                            popularRouteCore.length = data.longth
                            popularRouteCore.background = data.background
                            popularRouteCore.intruduction = data.intruduction
                            popularRouteCore.suburb = data.suburb
                            popularRouteCore.postcode = data.postcode
                            popularRouteCore.latitude = data.latitude
                            popularRouteCore.longitude = data.longitude
                            popularRouteCore.detail_text = data.detail_text
                            popularRouteCore.safety_tips = data.safety_tips
                            try? context.save()
                        }
                        print("update one + \(popularRouteCore.uid)")
                    }
                }
                if !found{
                    let entity = PopularRouteCore(context: context)
                    entity.name = data.name
                    entity.uid = Int16(data.id)
                    entity.map = data.map
                    entity.distance = data.distance
                    entity.distance = data.distance
                    entity.length = data.longth
                    entity.background = data.background
                    entity.intruduction = data.intruduction
                    entity.suburb = data.suburb
                    entity.postcode = data.postcode
                    entity.latitude = data.latitude
                    entity.longitude = data.longitude
                    entity.detail_text = data.detail_text
                    entity.safety_tips = data.safety_tips
                    entity.star = false
                    try? context.save()
                }
            }
            self.success = true
        } catch  {
            print("error")
            self.error = true
            return
        }
        
    }
    
}
