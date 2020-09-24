//
//  PlaceAmountCell.swift
//  MyOrderApp
//
//  Created by Apple on 9/11/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit

class PlaceAmountCell: UITableViewCell {

    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var discountValue: UILabel!
    @IBOutlet weak var netamount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
