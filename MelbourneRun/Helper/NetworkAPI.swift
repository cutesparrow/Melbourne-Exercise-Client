//
//  NetworkAPI.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 18/3/21.
//

import Foundation
import Alamofire
import MapKit



extension GymList{
    func loadGymList(location:CLLocationCoordinate2D,completion: @escaping (Result<GymList, Error>) -> Void)->DataRequest{
        NetworkManager.shared.requestGet(path: "gymList.json", parameters: ["lat":location.latitude,"long":location.longitude]) { result in
            switch result {
                        case let .success(data):
                            let parseResult: Result<GymList, Error> = NetworkManager.parseData(data)
                            completion(parseResult)
                        case let .failure(error):
                            completion(.failure(error))
                        }
        }
    }
}
