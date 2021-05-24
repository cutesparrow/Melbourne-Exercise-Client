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
    
    
    func initialGyms(location:CLLocationCoordinate2D,context:NSManagedObjectContext) {
        reloadGymListData(location: location, context: context)
        let fetchRequest : NSFetchRequest<GymCore> = GymCore.fetchRequest()
        let idDescriptor = NSSortDescriptor(key: "uid", ascending: true)
        fetchRequest.sortDescriptors = [idDescriptor]
        do {
            let result = try context.fetch(fetchRequest) as [GymCore]
            self.gyms = GymList(list: [])
            result.forEach { gym in
                let gym = Gym(id: Int(gym.uid), lat: gym.lat, long: gym.long, name: gym.name, Images: [], limitation: Int(gym.limitation), distance: gym.distance, star: gym.star, address: gym.address, classType: gym.classType, gymTime: GymTime(monday_start: (gym.gymTime?.monday_start)!, tuesday_start: (gym.gymTime?.tuesday_start)!, wednesday_start: (gym.gymTime?.wednesday_start)!, thursday_start: (gym.gymTime?.thursday_start)!, friday_start: (gym.gymTime?.friday_start)!, saturday_start: (gym.gymTime?.saturday_start)!, sunday_start: (gym.gymTime?.sunday_start)!, monday_close: (gym.gymTime?.monday_close)!, tuesday_close: (gym.gymTime?.tuesday_close)!, wednesday_close: (gym.gymTime?.wednesday_close)!, thursday_close: (gym.gymTime?.thursday_close)!, friday_close: (gym.gymTime?.friday_start)!, saturday_close: (gym.gymTime?.saturday_close)!, sunday_close: (gym.gymTime?.sunday_close)!))
                gyms.list.append(gym)
            }
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    
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
