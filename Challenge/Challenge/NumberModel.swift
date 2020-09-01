//
//  NumberModel.swift
//  Challenge
//
//  Created by Estelle Paus on 8/31/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import Foundation

class NumberModel: NSObject {
    
    var name: String = ""
    var imageUrl: String = ""
    var isSelected : Bool = false
    
    init(name: String, imageUrl: String,  isSelected:Bool = false) {
        self.name = name
        self.imageUrl = imageUrl
    }
    
}

