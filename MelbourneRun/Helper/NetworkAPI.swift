//
//  NetworkAPI.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 18/3/21.
//

import Foundation
import Alamofire
import MapKit




class NetworkAPI{
    
    static public func loadRoadSituation(location:CLLocationCoordinate2D,gymId:Int,completion: @escaping (Result<RecentlyRoadSituation, Error>) -> Void)->DataRequest{
        NetworkManager.shared.requestGet(path: "gym/roadSituation", parameters: ["gym_id":gymId,"user_lat":location.latitude,"user_long":location.longitude]) { result in
        switch result {
                    case let .success(data):
                        let parseResult: Result<RecentlyRoadSituation, Error> = NetworkManager.parseData(data)
                        completion(parseResult)
                    case let .failure(error):
                        completion(.failure(error))
                    }
    }
}
    
    
    static public func loadGymList(location:CLLocationCoordinate2D,completion: @escaping (Result<GymList, Error>) -> Void)->DataRequest{
        NetworkManager.shared.requestGet(path: "gym/list", parameters: ["lat":location.latitude,"long":location.longitude]) { result in
            switch result {
                        case let .success(data):
                            let parseResult: Result<GymList, Error> = NetworkManager.parseData(data)
                            completion(parseResult)
                        case let .failure(error):
                            completion(.failure(error))
                        }
        }
    }
    
    
    static public func loadJoggingPath(location:CLLocationCoordinate2D,ifreturn:String,completion: @escaping (Result<[Coordinate],Error>) -> Void)->DataRequest{
        NetworkManager.shared.requestGet(path: "jog/path", parameters: ["lat":location.latitude,"long":location.longitude,"ifreturn":ifreturn]) { result in
            switch result{
            case let .success(data):
                let parseResult: Result<[Coordinate],Error> = NetworkManager.parseData(data)
                completion(parseResult)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static public func getImageName(completion: @escaping (Result<String,Error>) -> Void) -> DataRequest{
        NetworkManager.shared.requestString(path: "poster/", parameters: nil) { result in
            switch result{
            case let .success(data):
                let requestResult = data
                completion(.success(requestResult))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static public func getSlogan(completion: @escaping (Result<String,Error>) -> Void) -> DataRequest{
        NetworkManager.shared.requestString(path: "slogan/", parameters: nil) { result in
            switch result{
            case let .success(data):
                let requestResult = data
                completion(.success(requestResult))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    static public func getSafeTips(completion: @escaping (Result<String,Error>) -> Void) -> DataRequest{
        NetworkManager.shared.requestString(path: "safeTips/", parameters: nil) { result in
            switch result{
            case let .success(data):
                let requestResult = data
                completion(.success(requestResult))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}


extension UserData{
    func getRoadSituation(location:CLLocationCoordinate2D,gymId:Int){
        
            loadRoadSituation(location: location,gymId:gymId)
        
    }
    func loadRoadSituation(location:CLLocationCoordinate2D,gymId:Int){
        let completion: (Result<RecentlyRoadSituation,Error>) -> Void = { result in
            switch result {
            case let .success(list): self.roadSituation = list
            case let .failure(error): print(error)
            }
        }
        _ = NetworkAPI.loadRoadSituation(location: location,gymId: gymId, completion: completion)
        
    }
}



extension UserData{
    func getSafeTips(){
        let completion: (Result<String,Error>) -> Void = {
            result in
            switch result {
            case let .success(name):
                self.safeTips = name
            case let .failure(error):
                print(error)
            }
        }
        _ = NetworkAPI.getSafeTips(completion: completion)
    }
}

extension UserData{
    func getPosterName(){
        let completion: (Result<String,Error>) -> Void = {
            result in
            switch result {
            case let .success(name):
                self.image = name
            case let .failure(error):
                print(error)
            }
        }
        _ = NetworkAPI.getImageName(completion: completion)
    }
}

extension UserData{
    func getSlogan(){
        let completion: (Result<String,Error>) -> Void = {
            result in
            switch result {
            case let .success(name):
                self.slogan = name
            case let .failure(error):
                print(error)
            }
        }
        _ = NetworkAPI.getSlogan(completion: completion)
    }
}

extension UserData{
    func getGymList(location:CLLocationCoordinate2D){
        if !self.gymList.list.isEmpty{
            return
        } else{
            loadGymListData(location:location)
        }
        
    }
    func reloadGymList(location:CLLocationCoordinate2D){
            loadGymListData(location:location)
        
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





