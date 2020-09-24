//  NumberOfSizesCell.swift
//  MyOrderApp
//  Created by RAKESH KUSHWAHA on 16/07/20.
//  Copyright © 2020 rakesh. All rights reserved.

import UIKit

class NumberOfSizesCell: UITableViewCell,UITextFieldDelegate {
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var qtyTextField: UITextField!
    @IBOutlet var removeButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if (selected) {
            self.qtyTextField.isEnabled = false;
        } else {
            self.qtyTextField.isEnabled = true;
        }
    }
    
}
