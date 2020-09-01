//
//  Network.swift
//  Challenge
//
//  Created by Estelle Paus on 8/27/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import Foundation
import UIKit
import os.log
import SystemConfiguration

protocol SessionProtocol {
    
     func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

enum Method: String {
    case get, post, put, delete
}

class Network {
    var session: SessionProtocol = URLSession.shared
    var theURL: URL?
    var timeoutInterval = 30.0
    var method: Method { return .get }
   // private var task: URLSessionDataTask?
    
    func makeRequest(urlString: String, completion:  @escaping (_ list: [DTOModel])->Void) {
        
        if (connectedToNetwork() == true) {
        
        var models = [DTOModel]()
        guard let url = URL(string: urlString) else { return }
        theURL = url
        var request = URLRequest(url: url)
        var headers = [String: String]()
        headers["Accept"] = "application/json"
        request.allHTTPHeaderFields = headers
        session.dataTask(with: request, completionHandler: { (data, response, error) in
            if let jsonData = data {
                if error != nil {
                    os_log("URLSession error %@",error.debugDescription)
                 return
             }
             models = self.parseResponse(data: jsonData) ?? models
             completion(models)
            }
        }).resume()
            
        } else {
               NotificationCenter.default.post(name: .noConnectivityNotification, object: nil )
            }
        
    }

    func parseResponse(data: Data) -> [DTOModel]? {
        print(data)
        do {
            let response = try DTOModel.decode(data: data)
            return response
            
        } catch {
            os_log("JSONDecoder error %@",error.localizedDescription)
        }
        
        return nil
    }
    
    func connectedToNetwork() -> Bool {

             var zeroAddress = sockaddr_in()
             zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
             zeroAddress.sin_family = sa_family_t(AF_INET)

             guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
                 $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                     SCNetworkReachabilityCreateWithAddress(nil, $0)
                 }
             }) else {
                 return false
             }

             var flags: SCNetworkReachabilityFlags = []
             if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
                 return false
             }

             let isReachable = flags.contains(.reachable)
             let needsConnection = flags.contains(.connectionRequired)

             return (isReachable && !needsConnection)
         }
    
}
extension URLSession: SessionProtocol {}
