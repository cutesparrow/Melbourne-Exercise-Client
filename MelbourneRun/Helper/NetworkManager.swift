//
//  NetworkHelper.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 18/3/21.
//

import Foundation
import Alamofire
import SwiftyJSON
// store all Network information

typealias NetworkRequestResult = Result<Data, Error>
typealias NetworkRequestCompletion = (NetworkRequestResult) -> Void

//"http://192.168.50.25:8000/"//
let NetworkAPIBaseURL = "http://192.168.50.25:8000/"//"http://www.melbournesafeexercise.tk/" //base url
let weatherWebsite = "http://api.weatherapi.com/v1/current.json" //weather url
let parameter:Parameters = ["key":"6ea4cd893fce4e32812101751212803","q":"Melbourne","aqi":"no"] //api token for weather

class NetworkManager {
    static let shared = NetworkManager()
    
    let urlBasePath:String = NetworkAPIBaseURL + "static/" //static resource
    
    var commonHeaders: HTTPHeaders { ["access-token": "2c4092daa53543069e0800b12522463c", "token": "sdkjfhldaksjfghlkjdshflalfgjk8g334jsh35h34ljk5h34543543"] } //secret token
    
    private init() {}
    
    @discardableResult
    func requestGet(path: String, parameters: Parameters?, completion: @escaping NetworkRequestCompletion) -> DataRequest { //get json request
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
    func requestWeather(completion: @escaping NetworkRequestCompletion) -> DataRequest { //get weather
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
    func requestString(path: String, parameters: Parameters?, completion: @escaping (Result<String,Error>) -> Void) -> DataRequest { //get string
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
    func requestPost(path: String, parameters: Parameters?, completion: @escaping NetworkRequestCompletion) -> DataRequest { //send post request
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
    
    private func handleError(_ error: AFError) -> NetworkRequestResult { //error handler
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
    
    static func parseData<T: Decodable>(_ data: Data) -> Result<T, Error> { //translate json to object 
        print(data.base64EncodedData())
            guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                let error = NSError(domain: "NetworkAPIError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Can not parse data"])
                return .failure(error)
            }
            return .success(decodedData)
        }
}
