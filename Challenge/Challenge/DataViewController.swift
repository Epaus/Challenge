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

        if let mod = model {
            view.isHidden = false
            self.nameLabel.text = mod.name 
            let url = (mod.imageUrl) as NSString
            let secureUrl = NSString.secureUrl(url as String)
            self.numberImageView.downloadImage(withUrlString: secureUrl )
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
