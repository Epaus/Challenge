//
//  DataViewController.swift
//  Challenge
//
//  Created by Estelle Paus on 8/30/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var numberImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    var model: NumberModel?
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.accessibilityIdentifier = ConstantText.detail_view
        if let mod = model {
            view.isHidden = false
            self.nameLabel.text = mod.name 
            let url = (mod.imageUrl) as NSString
            let secureUrl = NSString.secureUrl(url as String)
            self.numberImageView.downloadImage(withUrlString: secureUrl )
        }
    }
    
}
