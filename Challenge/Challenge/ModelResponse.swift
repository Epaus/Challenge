//
//  ModelResponse.swift
//  Challenge
//
//  Created by Estelle Paus on 8/27/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import Foundation

struct DTOModel : Codable {
    let name: String?
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
           case name
           case imageUrl = "image"
       }
    
    static func decode(data: Data) throws -> [DTOModel] {
        let decoder = JSONDecoder()
        return try decoder.decode(Array<DTOModel>.self, from: data)
    }
}
