//
//  customTableViewCell.swift
//  DBMUSIC
//
//  Created by panyong on 15/2/5.
//  Copyright (c) 2015年 monileNowGroup. All rights reserved.
//

import UIKit

class customTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgV: UIImageView!

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var time: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
