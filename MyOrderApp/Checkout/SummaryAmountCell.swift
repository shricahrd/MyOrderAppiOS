//
//  SummaryAmountCell.swift
//  MyOrderApp
//
//  Created by RAKESH KUSHWAHA on 15/07/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit

class SummaryAmountCell: UITableViewCell {
    @IBOutlet var viewBg: UIView!
    @IBOutlet var itemName: UILabel!
    @IBOutlet var amoutQty: UILabel!
    @IBOutlet var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
