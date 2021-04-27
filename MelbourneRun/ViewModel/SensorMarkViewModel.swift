//
//  SensorMarkViewModel.swift
//  MelbExercise
//
//  Created by gaoyu shi on 27/4/21.
//

import Foundation
import CoreData
import SwiftUI

class SensorMarkViewModel:ObservableObject{
    @Published var marks:[MarkerLocation] = []
    @Published var error:Bool = false
    @Published var success:Bool = false
    @Published var loading:Bool = false
    
    func getSensorSituation(context:NSManagedObjectContext){
        let completion: (Result<[MarkerLocation],Error>) -> Void = { result in
            switch result {
            case let .success(marks):
                self.marks = marks
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
        _ = NetworkAPI.loadSensorSituation(completion: completion)
    }
    
    func saveData(context:NSManagedObjectContext){
        self.marks.forEach { (data) in
            let entity = SensorMarkCore(context: context)
            
            entity.uid = Int16(data.id)
            entity.lat = data.lat
            entity.long = data.long
            entity.risk = data.risk
            
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
    func reGetSensorSituation(context:NSManagedObjectContext){
        let completion: (Result<[MarkerLocation],Error>) -> Void = { result in
            switch result {
            case let .success(marks):
                self.marks = marks
                self.refreshData(context: context)
//                self.saveData(context: context)
                self.success = true
                self.loading = false
            case let .failure(error):
                print(error)
                self.error = true
                self.loading = false
            }
        }
        self.loading = true
        _ = NetworkAPI.loadSensorSituation(completion: completion)
    }
    
    
    func refreshData(context:NSManagedObjectContext){
        let fetchRequest : NSFetchRequest<SensorMarkCore> = SensorMarkCore.fetchRequest()
        let idDescriptor = NSSortDescriptor(key: "uid", ascending: true)
        fetchRequest.sortDescriptors = [idDescriptor]
        print("start")
        do {
            let result = try context.fetch(fetchRequest) as [SensorMarkCore]
            self.marks.forEach { (data) in
                var found = false
                result.forEach { (mark) in
                    if data.id == mark.uid{
                        found = true
                        context.performAndWait {
                            mark.lat = data.lat
                            mark.long = data.long
                            mark.uid = Int16(data.id)
                            mark.risk = data.risk
                            try? context.save()
                        }
                        print("update one + \(mark.uid)")
                    }
                }
                if !found{
                    let entity = SensorMarkCore(context: context)
                    
                    entity.uid = Int16(data.id)
                    
                    entity.lat = data.lat
                    entity.long = data.long
                    entity.risk = data.risk
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
