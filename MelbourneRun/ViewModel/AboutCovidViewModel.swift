//
//  AboutCovidViewModel.swift
//  MelbExercise
//
//  Created by gaoyu shi on 30/4/21.
//

import Foundation
import SwiftUI
import CoreData

@objc(AboutCovidCore)
public class AboutCovidCore: NSManagedObject {

}
extension AboutCovidCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AboutCovidCore> {
        return NSFetchRequest<AboutCovidCore>(entityName: "AboutCovidCore")
    }

    @NSManaged public var uid: Int16
    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var background: String?
    @NSManaged public var color: String?
}

extension AboutCovidCore : Identifiable {

}



class AboutCovidViewModel:ObservableObject{
    @Published var aboutCovids:[AboutCovid] = []
    @Published var error:Bool = false
    @Published var success:Bool = false
    @Published var loading:Bool = false
    
    func getAboutCovidData(context:NSManagedObjectContext){
        let completion: (Result<[AboutCovid],Error>) -> Void = { result in
            switch result {
            case let .success(aboutCovids):
                self.aboutCovids = aboutCovids
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
        _ = NetworkAPI.loadAboutCovid(completion: completion)
    }
    
    func refreshData(context:NSManagedObjectContext){
        let fetchRequest : NSFetchRequest<AboutCovidCore> = AboutCovidCore.fetchRequest()
        let idDescriptor = NSSortDescriptor(key: "uid", ascending: true)
        fetchRequest.sortDescriptors = [idDescriptor]
        print("start")
        do {
            let result = try context.fetch(fetchRequest) as [AboutCovidCore]
            self.aboutCovids.forEach { (data) in
                var found = false
                result.forEach { (aboutCovid) in
                    if data.id == aboutCovid.uid{
                        found = true
                        context.performAndWait {
                            aboutCovid.title = data.title
                            aboutCovid.content = data.content
                            aboutCovid.uid = Int16(data.id) - 1
                            aboutCovid.background = data.background
                            aboutCovid.color = data.color
                            try? context.save()
                        }
                        print("update one + \(aboutCovid.uid)")
                    }
                }
                if !found{
                    let entity = AboutCovidCore(context: context)
                    entity.uid = Int16(data.id) - 1
                    entity.title = data.title
                    entity.content = data.content
                    entity.background = data.background
                    entity.color = data.color
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


struct AboutCovid:Hashable, Codable,Identifiable {
    var id:Int
    var title:String
    var content:String
    var background:String
    var color:String
}
