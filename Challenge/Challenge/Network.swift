//
//  Network.swift
//  Challenge
//
//  Created by Estelle Paus on 8/27/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import Foundation
import os.log

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
    private var task: URLSessionDataTask?
    
    func makeRequest(urlString: String, completion:  @escaping (_ list: [Model])->Void) {
        var models = [Model]()
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
    }

    func parseResponse(data: Data) -> [Model]? {
        print(data)
        do {
            let response = try Model.decode(data: data)
            return response
            
        } catch {
            print("JSONDecoder error \(error)")
        }
        
        return nil
    }
    
}
extension URLSession: SessionProtocol {}
