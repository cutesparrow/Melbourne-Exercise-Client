//
//  GymViewModel.swift
//  MelbExercise
//
//  Created by gaoyu shi on 25/4/21.
//

import Foundation
import CoreData
import SwiftUI

class GymViewModel:ObservableObject{
    @Published var gyms:GymList = GymList(list: [])
    @Published var error:Bool = false
    @Published var success:Bool = false
    @Published var loading:Bool = false
    
    func loadGymListData(location:CLLocationCoordinate2D,context:NSManagedObjectContext){
        let completion: (Result<GymList, Error>) -> Void = { result in
            switch result {
            case let .success(list):
                self.gyms = list
                self.saveData(context: context)
                self.success = true
                self.loading = false
            case let .failure(error):
                print(error)
                self.error = true
                self.loading = false
            }
        }
        self.loading = true
        _ = NetworkAPI.loadGymList(location: location, completion: completion)
    }
    
    func saveData(context:NSManagedObjectContext){
        self.gyms.list.forEach { (data) in
            let entity = GymCore(context: context)
            entity.address = data.address
            entity.uid = Int16(data.id)
            entity.classType = data.classType
            entity.distance = data.distance
            entity.lat = data.lat
            entity.long = data.long
            entity.limitation = Int16(data.limitation)
            entity.name = data.name
            entity.showName = ""
            data.Images.forEach { (image) in
                let imageCore = ImageCore(context: context)
                imageCore.name = image
                imageCore.uid = Int16(data.Images.firstIndex(where: { $0 == image })!)
                entity.addToImages(imageCore)
            }
            let gymTime = GymTimeCore(context: context)
            gymTime.monday_start = data.gymTime.monday_start
            gymTime.monday_close = data.gymTime.monday_close
            gymTime.tuesday_start = data.gymTime.tuesday_start
            gymTime.tuesday_close = data.gymTime.tuesday_close
            gymTime.wednesday_start = data.gymTime.wednesday_start
            gymTime.wednesday_close = data.gymTime.wednesday_close
            gymTime.thursday_start = data.gymTime.thursday_start
            gymTime.thursday_close = data.gymTime.thursday_close
            gymTime.friday_start = data.gymTime.friday_start
            gymTime.friday_close = data.gymTime.friday_close
            gymTime.saturday_start = data.gymTime.saturday_start
            gymTime.saturday_close = data.gymTime.saturday_close
            gymTime.sunday_start = data.gymTime.sunday_start
            gymTime.sunday_close = data.gymTime.sunday_close
            entity.gymTime = gymTime
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
    
    func reloadGymListData(location:CLLocationCoordinate2D,context:NSManagedObjectContext){
        let completion: (Result<GymList, Error>) -> Void = { result in
            switch result {
            case let .success(list):
                self.gyms = list
                withAnimation {
                    self.refreshData(context: context)
                    self.success = true
                    self.loading = false
                }
                
            case let .failure(error):
                print(error)
                self.error = true
                self.loading = false
            }
        }
        self.loading = true
        _ = NetworkAPI.loadGymList(location: location, completion: completion)
    }
    
    func refreshData(context:NSManagedObjectContext){
        let fetchRequest : NSFetchRequest<GymCore> = GymCore.fetchRequest()
        let idDescriptor = NSSortDescriptor(key: "uid", ascending: true)
        fetchRequest.sortDescriptors = [idDescriptor]
        print("start")
        do {
            let result = try context.fetch(fetchRequest) as [GymCore]
            self.gyms.list.forEach { (data) in
                var found = false
                result.forEach { (gymCore) in
                    if data.id == gymCore.uid{
                        found = true
                        context.performAndWait {
                            gymCore.lat = data.lat
                            gymCore.long = data.long
                            gymCore.name = data.name
                            gymCore.limitation = Int16(data.limitation)
                            gymCore.distance = data.distance
                            gymCore.address = data.address
                            gymCore.classType = data.classType
                            gymCore.images = nil
//                            gymCore.showName = ""
                            data.Images.forEach { (image) in
                                let imageCore = ImageCore(context: context)
                                imageCore.name = image
                                imageCore.uid = Int16(data.Images.firstIndex(where: { $0 == image })!)
                                gymCore.addToImages(imageCore)
                            }
                            let gymTime = GymTimeCore(context: context)
                            gymTime.monday_start = data.gymTime.monday_start
                            gymTime.monday_close = data.gymTime.monday_close
                            gymTime.tuesday_start = data.gymTime.tuesday_start
                            gymTime.tuesday_close = data.gymTime.tuesday_close
                            gymTime.wednesday_start = data.gymTime.wednesday_start
                            gymTime.wednesday_close = data.gymTime.wednesday_close
                            gymTime.thursday_start = data.gymTime.thursday_start
                            gymTime.thursday_close = data.gymTime.thursday_close
                            gymTime.friday_start = data.gymTime.friday_start
                            gymTime.friday_close = data.gymTime.friday_close
                            gymTime.saturday_start = data.gymTime.saturday_start
                            gymTime.saturday_close = data.gymTime.saturday_close
                            gymTime.sunday_start = data.gymTime.sunday_start
                            gymTime.sunday_close = data.gymTime.sunday_close
                            gymCore.gymTime = gymTime
                            
                            try? context.save()
                        }
                        print("update one + \(gymCore.uid)")
                    }
                }
                if !found{
                    let entity = GymCore(context: context)
                    entity.address = data.address
                    entity.uid = Int16(data.id)
                    entity.classType = data.classType
                    entity.distance = data.distance
                    entity.lat = data.lat
                    entity.long = data.long
                    entity.limitation = Int16(data.limitation)
                    entity.name = data.name
                    data.Images.forEach { (image) in
                        let imageCore = ImageCore(context: context)
                        imageCore.name = image
                        imageCore.uid = Int16(data.Images.firstIndex(where: { $0 == image })!)
                        entity.addToImages(imageCore)
                    }
                    let gymTime = GymTimeCore(context: context)
                    gymTime.monday_start = data.gymTime.monday_start
                    gymTime.monday_close = data.gymTime.monday_close
                    gymTime.tuesday_start = data.gymTime.tuesday_start
                    gymTime.tuesday_close = data.gymTime.tuesday_close
                    gymTime.wednesday_start = data.gymTime.wednesday_start
                    gymTime.wednesday_close = data.gymTime.wednesday_close
                    gymTime.thursday_start = data.gymTime.thursday_start
                    gymTime.thursday_close = data.gymTime.thursday_close
                    gymTime.friday_start = data.gymTime.friday_start
                    gymTime.friday_close = data.gymTime.friday_close
                    gymTime.saturday_start = data.gymTime.saturday_start
                    gymTime.saturday_close = data.gymTime.saturday_close
                    gymTime.sunday_start = data.gymTime.sunday_start
                    gymTime.sunday_close = data.gymTime.sunday_close
                    entity.gymTime = gymTime
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
