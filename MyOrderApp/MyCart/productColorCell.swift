//
//  productColorCell.swift
//  MyOrderApp
//
//  Created by RAKESH KUSHWAHA on 16/07/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit

class productColorCell: UITableViewCell {
    @IBOutlet var viewBg: UIView!
    @IBOutlet var color: UILabel!
    @IBOutlet var productColorName: UILabel!
    @IBOutlet var quantity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
