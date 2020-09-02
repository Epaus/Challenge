//
//  Constants.swift
//  Challenge
//
//  Created by Estelle Paus on 9/1/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import Foundation

struct ConstantText {
    static let master_tableview = "masterTableView"
    static let detail_view = "detailView"
    
    static func url()-> String {
        let infoPlistDict = Bundle.main.infoDictionary
        guard let  api: String = infoPlistDict?["API_ENDPOINT"] as? String  else { return ""}
        return "https://" + api
    }

}
