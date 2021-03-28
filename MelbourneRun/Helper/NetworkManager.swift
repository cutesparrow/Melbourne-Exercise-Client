//
//  NetworkHelper.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 18/3/21.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias NetworkRequestResult = Result<Data, Error>
typealias NetworkRequestCompletion = (NetworkRequestResult) -> Void


let NetworkAPIBaseURL = "http://192.168.50.25:8000/"
let weatherWebsite = "http://api.weatherapi.com/v1/current.json"
let parameter:Parameters = ["key":"6ea4cd893fce4e32812101751212803","q":"Melbourne","aqi":"no"]

class NetworkManager {
    static let shared = NetworkManager()
    
    let urlBasePath:String = NetworkAPIBaseURL + "gym/static/"
    
    var commonHeaders: HTTPHeaders { ["user_id": "123", "token": "XXXXXX"] }
    var headers:HTTPHeaders{["x-rapidapi-key": "7fb741c52emsh947579efc8a61c6p12020ajsn22817aa1fd55","x-rapidapi-host": "community-open-weather-map.p.rapidapi.com"]}
    
    private init() {}
    
    @discardableResult
    func requestGet(path: String, parameters: Parameters?, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        AF.request(NetworkAPIBaseURL + path,
                   parameters: parameters,
                   headers: commonHeaders,
                   requestModifier: { $0.timeoutInterval = 15 })
            .responseData { response in
                switch response.result {
                case let .success(data): completion(.success(data))
                case let .failure(error): completion(self.handleError(error))
                }
        }
    }
    
    @discardableResult
    func requestWeather(completion: @escaping NetworkRequestCompletion) -> DataRequest {
        AF.request(weatherWebsite,
                   parameters: parameter,
                   requestModifier: { $0.timeoutInterval = 15 })
            .responseData { response in
                switch response.result {
                case let .success(data): completion(.success(data))
                case let .failure(error): completion(self.handleError(error))
                }
        }
    }
   
    
    
    @discardableResult
    func requestString(path: String, parameters: Parameters?, completion: @escaping (Result<String,Error>) -> Void) -> DataRequest {
        AF.request(NetworkAPIBaseURL + path,
                   parameters: parameters,
                   headers: commonHeaders,
                   requestModifier: { $0.timeoutInterval = 15 })
            .responseString { response in
                switch response.result {
                case let .success(data): completion(.success(data))
                case let .failure(error): completion(.failure(error))
                }
        }
    }
    
    @discardableResult
    func requestPost(path: String, parameters: Parameters?, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        AF.request(NetworkAPIBaseURL + path,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.prettyPrinted,
                   headers: commonHeaders,
                   requestModifier: { $0.timeoutInterval = 15 })
            .responseData { response in
                switch response.result {
                case let .success(data): completion(.success(data))
                case let .failure(error): completion(self.handleError(error))
                }
        }
    }
    
    private func handleError(_ error: AFError) -> NetworkRequestResult {
        if let underlyingError = error.underlyingError {
            let nserror = underlyingError as NSError
            let code = nserror.code
            if  code == NSURLErrorNotConnectedToInternet ||
                code == NSURLErrorTimedOut ||
                code == NSURLErrorInternationalRoamingOff ||
                code == NSURLErrorDataNotAllowed ||
                code == NSURLErrorCannotFindHost ||
                code == NSURLErrorCannotConnectToHost ||
                code == NSURLErrorNetworkConnectionLost {
                var userInfo = nserror.userInfo
                userInfo[NSLocalizedDescriptionKey] = "网络连接有问题喔～"
                let currentError = NSError(domain: nserror.domain, code: code, userInfo: userInfo)
                return .failure(currentError)
            }
        }
        return .failure(error)
    }
    
    static func parseData<T: Decodable>(_ data: Data) -> Result<T, Error> {
        print(data.base64EncodedData())
            guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                let error = NSError(domain: "NetworkAPIError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Can not parse data"])
                return .failure(error)
            }
            return .success(decodedData)
        }
}
