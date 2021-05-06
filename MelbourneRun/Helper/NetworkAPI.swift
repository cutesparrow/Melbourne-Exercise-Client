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
    
    static public func loadAboutCovid(completion: @escaping (Result<[AboutCovid], Error>) -> Void)->DataRequest{
        NetworkManager.shared.requestGet(path: "aboutCovid/", parameters: nil) { result in
        switch result {
                    case let .success(data):
                        let parseResult: Result<[AboutCovid], Error> = NetworkManager.parseData(data)
                        completion(parseResult)
                    case let .failure(error):
                        completion(.failure(error))
                    }
    }
}
    
    static public func loadShowInformation(completion: @escaping (Result<ShowInformation, Error>) -> Void)->DataRequest{
        NetworkManager.shared.requestGet(path: "showInformation/", parameters: nil) { result in
        switch result {
                    case let .success(data):
                        let parseResult: Result<ShowInformation, Error> = NetworkManager.parseData(data)
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
   
    
    static public func loadPopularCards(location:CLLocationCoordinate2D,completion: @escaping (Result<[PopularJoggingRoute], Error>) -> Void)->DataRequest{
        NetworkManager.shared.requestGet(path: "jog/path/popular", parameters: ["lat":location.latitude,"long":location.longitude]) { result in
            switch result {
                        case let .success(data):
                            let popularList: Result<[PopularJoggingRoute], Error> = NetworkManager.parseData(data)
                            completion(popularList)
                        case let .failure(error):
                            completion(.failure(error))
                        }
        }
    }
    
    static public func loadCustomizedCards(location:CLLocationCoordinate2D,length:Double,type:String,completion: @escaping (Result<[WalkingRouteCard], Error>) -> Void)->DataRequest{
        NetworkManager.shared.requestGet(path: "jog/path/customize", parameters: ["lat":location.latitude,"long":location.longitude,"length":length,"type":type]) { result in
            switch result {
                        case let .success(data):
                            let customizeList: Result<[WalkingRouteCard], Error> = NetworkManager.parseData(data)
                            completion(customizeList)
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
    
    static public func getWeatherInfo(completion: @escaping (Result<WeatherNow,Error>) -> Void)->DataRequest{
        NetworkManager.shared.requestWeather() { result in
            switch result{
            case let .success(data):
                let parseResult: Result<WeatherNow,Error> = NetworkManager.parseData(data)
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
    
    static public func getExercise(completion: @escaping (Result<String,Error>) -> Void) -> DataRequest{
        NetworkManager.shared.requestString(path: "exerciseTips/", parameters: nil) { result in
            switch result{
            case let .success(data):
                let requestResult = data
                completion(.success(requestResult))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static public func loadSafetyPolicy(completion: @escaping (Result<[SafetyPolicy],Error>) -> Void)->DataRequest{
        NetworkManager.shared.requestGet(path: "safePolicy/",parameters: nil) { result in
            switch result{
            case let .success(data):
                let parseResult: Result<[SafetyPolicy],Error> = NetworkManager.parseData(data)
                completion(parseResult)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    static public func loadSensorSituation(completion: @escaping (Result<[MarkerLocation],Error>) -> Void)->DataRequest{
        NetworkManager.shared.requestGet(path: "jog/sensorLocation/",parameters: nil) { result in
            switch result{
            case let .success(data):
                let parseResult: Result<[MarkerLocation],Error> = NetworkManager.parseData(data)
                completion(parseResult)
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


class NetworkRequest{
    // send network request
}

//extension UserData{
//    func getSensorSituation(){
//        let completion: (Result<[MarkerLocation],Error>) -> Void = { result in
//            switch result {
//            case let .success(marks): self.marks = marks
//            case let .failure(error): print(error)
//            }
//        }
//        _ = NetworkAPI.loadSensorSituation(completion: completion)
//    }
//}

//extension UserData{
//    func getShowInformation(){
//        let completion: (Result<ShowInformation,Error>) -> Void = { result in
//            switch result {
//            case let .success(information): self.showInformation = information
//            case let .failure(error): print(error)
//            }
//        }
//        _ = NetworkAPI.loadShowInformation(completion: completion)
//        
//    }
//}

extension UserData{
    func getWeatherDataNow(){
        let completion: (Result<WeatherNow,Error>) -> Void = { result in
            switch result {
            case let .success(weather): self.weather = weather
            case let .failure(error): print(error)
            }
        }
        _ = NetworkAPI.getWeatherInfo(completion: completion)
        
    }
}

//extension UserData{
//    
//    func getRoadSituation(location:CLLocationCoordinate2D,gymId:Int){
//            loadRoadSituation(location: location,gymId:gymId)
//    }
//    
//    func loadRoadSituation(location:CLLocationCoordinate2D,gymId:Int){
//        let completion: (Result<RecentlyRoadSituation,Error>) -> Void = { result in
//            switch result {
//            case let .success(list): self.roadSituation = list
//            case let .failure(error): print(error)
//            }
//        }
//        _ = NetworkAPI.loadRoadSituation(location: location,gymId: gymId, completion: completion)
//    }
//}

extension UserData{
    func loadJoggingPath(){
        let completion: (Result<[SafetyPolicy],Error>) -> Void = { result in
            switch result {
            case let .success(list): self.safetyPolicy = list
            case let .failure(error): print(error)
            }
        }
        _ = NetworkAPI.loadSafetyPolicy(completion: completion)
        
    }
}


//
//extension UserData{
//    func getSafeTips(){
//        let completion: (Result<String,Error>) -> Void = {
//            result in
//            switch result {
//            case let .success(name):
//                self.safeTips = name
//            case let .failure(error):
//                print(error)
//            }
//        }
//        _ = NetworkAPI.getSafeTips(completion: completion)
//    }
//}
//
//extension UserData{
//    func getPosterName(){
//        let completion: (Result<String,Error>) -> Void = {
//            result in
//            switch result {
//            case let .success(name):
//                self.image = name
//            case let .failure(error):
//                print(error)
//            }
//        }
//        _ = NetworkAPI.getImageName(completion: completion)
//    }
//}

//extension UserData{
//    func getExercise(){
//        let completion: (Result<String,Error>) -> Void = {
//            result in
//            switch result {
//            case let .success(name):
//                self.exerciseTips = name
//            case let .failure(error):
//                print(error)
//            }
//        }
//        _ = NetworkAPI.getExercise(completion: completion)
//    }
//}

//extension UserData{
//    func getGymList(location:CLLocationCoordinate2D){
//        if !self.gymList.list.isEmpty{
//            return
//        } else{
//            loadGymListData(location:location)
//        }
//        
//    }
//    func reloadGymList(location:CLLocationCoordinate2D){
//            loadGymListData(location:location)
//        
//    }
//    func loadGymListData(location:CLLocationCoordinate2D){
//        let completion: (Result<GymList, Error>) -> Void = { result in
//            switch result {
//            case let .success(list): self.gymList = list
//            case let .failure(error): print(error)
//            }
//            
//        }
//        _ = NetworkAPI.loadGymList(location: location, completion: completion)
//    }
//}

extension UserData{
//    func getGymList(location:CLLocationCoordinate2D){
//        if !self.gymList.list.isEmpty{
//            return
//        } else{
//            loadGymListData(location:location)
//        }
//
//    }
//    func reloadGymList(location:CLLocationCoordinate2D){
//            loadGymListData(location:location)
//
//    }
//    func loadPopularCardsData(location:CLLocationCoordinate2D){
//        let completion: (Result<[PopularCard], Error>) -> Void = { result in
//            switch result {
//            case let .success(list): self.popularCards = list
//            case let .failure(error): print(error)
//            }
//            
//        }
//        _ = NetworkAPI.loadPopularCards(location: location, completion: completion)
//    }
}

extension UserData{
//    func getGymList(location:CLLocationCoordinate2D){
//        if !self.gymList.list.isEmpty{
//            return
//        } else{
//            loadGymListData(location:location)
//        }
//
//    }
//    func reloadGymList(location:CLLocationCoordinate2D){
//            loadGymListData(location:location)
//
//    }
//    func loadCustomizedCardsData(location:CLLocationCoordinate2D){
//        let completion: (Result<[CustomizedCard], Error>) -> Void = { result in
//            switch result {
//            case let .success(list): self.customizedCards = list
//            case let .failure(error): print(error)
//            }
//
//        }
//        _ = NetworkAPI.loadCustomizedCards(location: location, completion: completion)
//    }
}

//extension UserData{
//    func getJoggingPath(location:CLLocationCoordinate2D,ifreturn:String){
//        if self.joggingPath.count != 1{
//            return
//        } else{
//            loadJoggingPath(location: location, ifreturn: ifreturn)
//        }
//    }
//    func loadJoggingPath(location:CLLocationCoordinate2D,ifreturn:String){
//        let completion: (Result<[Coordinate],Error>) -> Void = { result in
//            switch result {
//            case let .success(list): self.joggingPath = list
//            case let .failure(error): print(error)
//            }
//        }
//        _ = NetworkAPI.loadJoggingPath(location: location, ifreturn: ifreturn, completion: completion)
//    }
//}

extension UserData{
    func getSafePolicy(){
        let completion: (Result<[SafetyPolicy],Error>) -> Void = { result in
            switch result {
            case let .success(list): self.safetyPolicy = list
            case let .failure(error): print(error)
            }
        }
        _ = NetworkAPI.loadSafetyPolicy(completion: completion)
        
    }
}




