//
//  searchcontrollerCell.swift
//  MyOrderApp
//
//  Created by Apple on 8/11/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit

class searchcontrollerCell: UITableViewCell {

    @IBOutlet weak var lblcell: UILabel!
    @IBOutlet weak var btncheckuncheck: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
