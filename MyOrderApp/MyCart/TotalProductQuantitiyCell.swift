//
//  TotalProductQuantitiyCell.swift
//  MyOrderApp
//
//  Created by RAKESH KUSHWAHA on 16/07/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit

class TotalProductQuantitiyCell: UITableViewCell {

    @IBOutlet var totalQuantity: UILabel!
    @IBOutlet var totalAmount: UILabel!
    @IBOutlet var discountAmount: UILabel!
    @IBOutlet var netAmount: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
