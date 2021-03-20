//
//  UserData.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 18/3/21.
//


import Foundation
import Combine
import MapKit

class UserData: ObservableObject {
    @Published var gymList: GymList = GymList(list: [ Gym(id: 1,
                                                      lat: -37.81182294764945,
                                                      long: 144.96396366254962,
                                                      name: "Fitness First Bourke St",
                                                      Images: ["gym1","gym2","gym3"],
                                                      limitation: 21, distance: 3.23,
                                                      star: false,
                                                      address: "Level 2/341-345 Bourke St, Melbourne VIC 3000")])
    @Published var parkList: ParkList = ParkList(list: [])
    @Published var playgroundList: PlaygroundList = PlaygroundList(list: [])
    @Published var joggingPath:[CLLocationCoordinate2D] = []
}

extension UserData{
    func getGymList(location:CLLocationCoordinate2D){
        if !self.gymList.list.isEmpty{
            return
        
        } else{
            loadGymListData(location:location)
        }
        
    }
    func loadGymListData(location:CLLocationCoordinate2D){
        let completion: (Result<GymList, Error>) -> Void = { result in
            switch result {
            case let .success(list): self.gymList = list
            case let .failure(error): print(error)
            }
            
        }
        _ = gymList.loadGymList(location: location, completion: completion)
    }
}

extension UserData{
    func getJoggingPath(location:CLLocationCoordinate2D){
        self.joggingPath = [CLLocationCoordinate2D(latitude: -37.81228028830977, longitude: 144.96229225616813),
                            CLLocationCoordinate2D(latitude: -37.816196112093316, longitude: 144.96404105636753),CLLocationCoordinate2D(latitude: -37.81470439418989, longitude: 144.96899777840505)]
    }
}
