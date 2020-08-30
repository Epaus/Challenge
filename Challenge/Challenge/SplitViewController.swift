//
//  SplitViewController.swift
//  Challenge
//
//  Created by Estelle Paus on 8/29/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import UIKit

class SplitViewController: UISplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidLayoutSubviews() {
        self.preferredPrimaryColumnWidthFraction = 0.50
    }

}
