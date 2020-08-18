//
//  ShippingAddressCell.swift
//  MyOrderApp
//
//  Created by RAKESH KUSHWAHA on 13/07/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit

class ShippingAddressCell: UITableViewCell {
    @IBOutlet var viewBG: UIView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var btnEddit: UIButton!
    @IBOutlet var btnDelete: UIButton!
    
    @IBOutlet var btnCheckUnckeck: UIButton!
    @IBOutlet var lblUseastheshiipingaddress: UILabel!
    
    
    @IBOutlet var lblAddress: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
