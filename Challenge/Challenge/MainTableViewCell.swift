//
//  MainTableViewCell.swift
//  Challenge
//
//  Created by Estelle Paus on 8/27/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var numberImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    var highlightedState: Bool = false

    var model: Model? {
        didSet {
            nameLabel.text = model?.name ?? "0"
            let url = (model?.imageUrl! ?? "") as NSString   
            let secureUrl = NSString.secureUrl(url as String)
            numberImageView.downloadImage(withUrlString: secureUrl )
        }
    }
    
    override func layoutSubviews() {
        self.highlightedState = false
        self.backgroundColor = .white
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
      
        self.highlightedState = false
        self.backgroundColor = .white
        self.model = nil
        
    }

}
