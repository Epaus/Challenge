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
    
   // var highlightedState: Bool = false

    var model: NumberModel? {
        didSet {
            nameLabel.text = model?.name ?? "0"
            let url = (model?.imageUrl ?? "") as NSString   
            let secureUrl = NSString.secureUrl(url as String)
            numberImageView.downloadImage(withUrlString: secureUrl )
        }
    }
    
    override func layoutSubviews() {
        if (model?.isSelected == true) {
            self.contentView.backgroundColor = .systemTeal
        } else {
            self.contentView.backgroundColor = .white
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        //highlightedState = false
        contentView.backgroundColor = .white
        super.prepareForReuse()
    }
}
