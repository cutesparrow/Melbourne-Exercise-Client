//
//  ExerciseTipViewModel.swift
//  MelbExercise
//
//  Created by gaoyu shi on 10/5/21.
//

import Foundation
import SwiftUI
import CoreData

struct ExerciseTip:Hashable, Codable,Identifiable {
    var id:Int
    var content:String
    var tipClass:String
}


class ExerciseTipViewModel:ObservableObject {
    @Published var exerciseTips:[ExerciseTip] = []
    @Published var error:Bool = false
    @Published var success:Bool = false
    @Published var loading:Bool = false
    func getExerciseTips(context:NSManagedObjectContext){
        let completion: (Result<[ExerciseTip],Error>) -> Void = { result in
            switch result {
            case let .success(data):
                self.exerciseTips = data
                self.refreshData(context: context)
                self.success = true
                self.loading = false
            case let .failure(error):
                print(error)
                self.error = true
                self.loading = false
            }
        }
        self.loading = true
        _ = NetworkAPI.loadExerciseTips(completion: completion)
    }
    
    func refreshData(context:NSManagedObjectContext){
        let fetchRequest : NSFetchRequest<ExerciseTipsCore> = NSFetchRequest<ExerciseTipsCore>(entityName: "ExerciseTipsCore")
        let idDescriptor = NSSortDescriptor(key: "uid", ascending: true)
        fetchRequest.sortDescriptors = [idDescriptor]
        print("start")
        do {
            let result = try context.fetch(fetchRequest) as [ExerciseTipsCore]
            self.exerciseTips.forEach { (data) in
                var found = false
                result.forEach { (exerciseTip) in
                    if data.id == exerciseTip.uid{
                        found = true
                        context.performAndWait {
                            exerciseTip.content = data.content
                            exerciseTip.uid = Int16(data.id) - 1
                            exerciseTip.tipClass = data.tipClass
                            try? context.save()
                        }
                        print("update one + \(exerciseTip.uid)")
                    }
                }
                if !found{
                    let entity = ExerciseTipsCore(context: context)
                    entity.uid = Int16(data.id) - 1
                    entity.content = data.content
                    entity.tipClass = data.tipClass
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
