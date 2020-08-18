//
//  InvoiceCell.swift
//  MyOrderApp
//
//  Created by RAKESH KUSHWAHA on 13/07/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit

class InvoiceCell: UITableViewCell {

    @IBOutlet var viewBG: UIView!
    @IBOutlet var lblTitale: UILabel!
    
    @IBOutlet var lblDate: UILabel!
    
    @IBOutlet var lblOrderId: UILabel!
    @IBOutlet var lblSuplier: UILabel!
    @IBOutlet var lblSuplierName: UILabel!
    
    @IBOutlet var lblTAmount: UILabel!
    
    @IBOutlet var lblAmount: UILabel!
    @IBOutlet var btnPayNaow: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
