//
//  DetailViewController.swift
//  Challenge
//
//  Created by Estelle Paus on 8/27/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailView: UIView!
    
    @IBOutlet weak var numberImageView: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    var model : Model?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if model != nil {
            detailView.isHidden = false
        }

        name.text = model?.name ?? "no name given"
        let url = (model?.imageUrl! ?? "") as NSString
        let secureUrl = NSString.secureUrl(url as String)
        self.numberImageView.downloadImage(withUrlString: secureUrl )
       
    }
    
}
