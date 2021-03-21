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
    @Published var gymList: GymList = GymList(list: [ ])
    @Published var parkList: ParkList = ParkList(list: [])
    @Published var playgroundList: PlaygroundList = PlaygroundList(list: [])
    @Published var joggingPath:[Coordinate] = [Coordinate(latitude: -37.80912284071033, longitude: 144.95963315775296)]
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
        _ = NetworkAPI.loadGymList(location: location, completion: completion)
    }
}

extension UserData{
    func getJoggingPath(location:CLLocationCoordinate2D,ifreturn:String){
        if self.joggingPath.count != 1{
            return
        } else{
            loadJoggingPath(location: location, ifreturn: ifreturn)
        }
    }
    func loadJoggingPath(location:CLLocationCoordinate2D,ifreturn:String){
        let completion: (Result<[Coordinate],Error>) -> Void = { result in
            switch result {
            case let .success(list): self.joggingPath = list
            case let .failure(error): print(error)
            }
        }
        _ = NetworkAPI.loadJoggingPath(location: location, ifreturn: ifreturn, completion: completion)
        
    }
}



