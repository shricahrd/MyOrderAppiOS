//
//  AmountCell.swift
//  MyOrderApp
//
//  Created by Apple on 9/10/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit

class AmountCell: UITableViewHeaderFooterView , UITextFieldDelegate{
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var textFieldCoupon: UITextField!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var amountText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        textFieldCoupon.delegate = self
        // Initialization code
    }


}
