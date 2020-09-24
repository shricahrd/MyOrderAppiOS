//  MyCartProductCell.swift
//  MyOrderApp
//  Created by RAKESH KUSHWAHA on 15/07/20.
//  Copyright © 2020 rakesh. All rights reserved.

import UIKit

class MyCartProductCell: UITableViewCell {
    @IBOutlet var viewBg: UIView!
    
    @IBOutlet var imageproduct: UIImageView!
    
    @IBOutlet var deleteProduct: UIButton!
    @IBOutlet var nameproduct: UILabel!
    @IBOutlet var serialNumber: UILabel!
    @IBOutlet var vendor: UILabel!
    @IBOutlet var fashionName: UILabel!
   
    @IBOutlet var colorName: UILabel!
    @IBOutlet var productColorName: UILabel!
    
    @IBOutlet var quantity: UILabel!
    @IBOutlet var dropDownButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
