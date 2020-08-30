//
//  AlertController.swift
//  Challenge
//
//  Created by Estelle Paus on 8/29/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import UIKit

struct AlertController {
    
    static func createAlert(title: String, message: String, actions: [UIAlertAction]) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        return alert
    }
    
}
