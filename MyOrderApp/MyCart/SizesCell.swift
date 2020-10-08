//  SizesCell.swift
//  MyOrderApp
//  Created by Apple on 9/28/20.
//  Copyright © 2020 rakesh. All rights reserved.

import UIKit

class SizesCell: UITableViewCell {
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var textFieldQty: UITextField!
    @IBOutlet weak var removeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
