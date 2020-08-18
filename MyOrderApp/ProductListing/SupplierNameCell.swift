//
//  SupplierNameCell.swift
//  MyOrderApp
//
//  Created by RAKESH KUSHWAHA on 26/07/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit

class SupplierNameCell: UITableViewCell {
    @IBOutlet var viewBg: UIView!
    @IBOutlet var name: UILabel!
    @IBOutlet var supplierName: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
