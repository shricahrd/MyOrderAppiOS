//
//  TotalQuantityCell.swift
//  MyOrderApp
//
//  Created by RAKESH KUSHWAHA on 15/07/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit

class TotalQuantityCell: UITableViewCell {
    @IBOutlet var amountHeader: UILabel!
    @IBOutlet var totalPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
