//  CartListCell.swift
//  MyOrderApp
//  Created by Apple on 9/6/20.
//  Copyright © 2020 rakesh. All rights reserved.


import UIKit
class CartListCell: UITableViewHeaderFooterView {
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var productimage: UIImageView!
    @IBOutlet weak var productname: UILabel!
    @IBOutlet weak var brandname: UILabel!
    @IBOutlet weak var supplierName: UILabel!
    @IBOutlet weak var colorBg: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var dropDown: UIButton!
    @IBOutlet weak var quantityValue: UILabel!
    @IBOutlet weak var colorText: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }


    
}
