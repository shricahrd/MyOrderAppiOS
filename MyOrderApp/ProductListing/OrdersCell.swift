//
//  OrdersCell.swift
//  MyOrderApp
//
//  Created by Apple on 9/24/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit

class OrdersCell: UITableViewCell {
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var orderNo: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var supplierName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var approved: UILabel!
    @IBOutlet weak var deliveredstatus: UILabel!
    @IBOutlet weak var moreDetail: UIButton!
    @IBOutlet weak var imageApproved: UIImageView!
    @IBOutlet weak var imageDelivered: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
