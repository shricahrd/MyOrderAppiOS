//
//  ProductDetailCell.swift
//  MyOrderApp
//
//  Created by RAKESH KUSHWAHA on 26/07/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit

class ProductDetailCell: UITableViewCell {
    
    @IBOutlet var viewBg: UIView!
    @IBOutlet var productName: UILabel!
    @IBOutlet var productcolor: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var discountPrice: UILabel!
    @IBOutlet var quantity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
